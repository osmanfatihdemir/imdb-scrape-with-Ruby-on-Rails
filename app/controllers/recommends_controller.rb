class RecommendsController<ApplicationController
    def index
        @movies=Recommend.all
    end

    def recommendsAddMovie
        #@recommends
    end


    def scrape
        url = 'https://www.imdb.com/title/tt4513678/?ref_=adv_li_tt'
        response = RecommendsSpider.process(url)
        if response[:status] == :completed && response[:error].nil?
          flash[:notice] = "Successfully scraped url"
        else
          flash[:alert] = response[:error]
        end
      rescue StandardError => e
        flash[:alert] = "Error: #{e}"
    end
end
