require 'kimurai'
require 'rubygems'
require 'nokogiri'

class MoviesSpider < Kimurai::Base
    @name = 'movies_spider'
    @engine = :mechanize
  
    def self.process(url)
      @start_urls = [url]
      self.crawl!
      
    end
  
    def parse(response, url:, data: {})
      response.xpath("//div[@class='lister-item mode-advanced']").each do |movie|
        item = {}
        
        
        itemCode  = movie.css('div.lister-item-image a img').attr('data-tconst').value
        item[:code] =itemCode
        puts "code: #{itemCode}"
        puts "code: #{item[:code]}"
        itemCategory     = movie.css('div.lister-item-content p.text-muted span.genre').text.squish
        item[:category]=itemCategory
        puts "category: #{item[:category]}"
        item[:title]      = movie.css('div.lister-item-content h3 a').text.squish
        item[:link] = movie.css('div.lister-item-content h3 a').attr('href').value
        item[:img]      = movie.css('div.lister-item-image a img').attr('src').value
        item[:star_point]      = movie.css('div.lister-item-content div.ratings-bar strong').text.to_s.gsub(',', '.').to_f
        puts "start point: #{item[:star_point]}"
        item[:explain]      = movie.css('div.lister-item-content p.text-muted')[1].text
        item[:cast] = movie.css('div.lister-item-content p')[2].text

        #puts "Output: #{item}"

  
        Movie.where(item).first_or_create

      end
    end
  end