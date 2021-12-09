class MoviesController<ApplicationController
  before_action :set_movies, only:[:show, :edit, :update, :destroy]
    def index
      @movies=Movie.all
    end

    def userAddMovie
      @claims= MovieUserClaim.where(user_id:params[:user_id], movie_id:params[:movie_id]).first_or_create
      if @claims.save
        redirect_to mymovies_path, notice:"Successfully added movie !!!"
      end
      
    end

    def userDeleteMovie
      @claimsDelete= MovieUserClaim.delete_by(user_id:params[:user_id], movie_id:params[:movie_id])
        redirect_to mymovies_path, notice:"Successfully deleted movie !!!"

    end

    def getMyMovie
      if Current.user
        allMovieId= MovieUserClaim.where(user_id: Current.user.id)
        puts allMovieId.inspect
        @myMovies= Movie.where(id: allMovieId.map { |allMovieId| allMovieId["movie_id"] })
      end
    end

  

    def scrape
      puts "test scrape"
        url = 'https://www.imdb.com/search/title/?genres=romance&explore=title_type,genres&pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=e0da8c98-35e8-4ebd-8e86-e7d39c92730c&pf_rd_r=5VZB6XJRSFDRME7297KT&pf_rd_s=center-2&pf_rd_t=15051&pf_rd_i=genre&ref_=ft_gnr_pr2_i_1'
        response = MoviesSpider.process(url)
        if response[:status] == :completed && response[:error].nil?
          flash[:notice] = "Successfully scraped url"
        else
          flash[:alert] = response[:error]
        end
      rescue StandardError => e
        flash[:alert] = "Error: #{e}"
    end

    


end
