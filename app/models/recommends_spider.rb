require 'kimurai'
require 'rubygems'
require 'nokogiri'

class RecommendsSpider< Kimurai::Base
    @name = 'recommends_spider'
    @engine = :mechanize
  
    def self.process(url)
      @start_urls = [url]
      self.crawl!
      
    end
  
    def parse(response, url:, data: {})
      puts "url: #{url}"
      puts response.xpath("//body")
      #response.xpath("//div[@class='ipc-poster-card ipc-poster-card--base']").each do |recommends|
        item = {}
        itemCode=url.to_s.split('/')
        
        puts "code: #{itemCode}"
        item[:movie_code] =itemCode.last
        puts "code: #{item[:movie_code]}"
        
        item[:img]  = recommends.xpath('img.ipc-image').attr('src').value

        item[:title]      = recommends.xpath('img.ipc-image').attr('alt').value
        item[:star_point]      = recommends.css('span.ipc-rating-star').text.to_s.gsub(',', '.').to_f
        puts "start point: #{item[:star_point]}"


        #puts "Output: #{item}"

  
        Recommend.where(item).first_or_create

      #end
    end
end