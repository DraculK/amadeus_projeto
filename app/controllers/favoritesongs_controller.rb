class FavoritesongsController < ApplicationController

    ##### Autenticação #####
    before_action :require_login

    ##### SHOW #####
    def index
        @current_user = User.find(session["user_id"])
        @listener = @current_user.listener
        @favorite = FavoriteSong.where(listener_id: @listener)
        @song = Song.all
    end

    ###### CREATE #####
    def new
        @favorite = FavoriteSong.new
    end
    
    def create
        @favorite = FavoriteSong.new(favorite_params)
        @favorite.save
    end

    ##### DELETE #####
    def destroy
        @favorite = FavoriteSong.find(params[:id])
        @favorite.destroy
        redirect_to favoritesongs_path
    end

    # ADD IN A PRIVATE METHOD FOR FAVORITESONGS_PARAMS
    private
        def favorite_params
            params.require(:favorite).permit(:user_id, :song_id)
        end

        def require_login
            unless logged_in?
                flash[:error] = "Você precisa estar logado"
                redirect_to "/auth/login"
            end
        end
end