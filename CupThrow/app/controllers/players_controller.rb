require_relative 'Maddie/GamePlayer.rb'
require_relative 'Maddie/RandomizerFactory.rb'

class PlayersController < ApplicationController
    def index
        @players = Player.all
    end

    def new
        @player = Player.new
    end

    def show
        @player = Player.find(params[:id])
    end

    def create
        # signing in an existing user
        if params[:commit] == "Sign In"
            sign_in
            return
        end

        # signing up
        @player = Player.new(player_params)
        @player.points = 0
        @player.gems = 0

        # create new Ruby 'Player' object and 'fill' it with the default bag contents
        @player.bag_desc = "{\"0\":{\"item\":\":coin\",\"denomination\":0.25},\"1\":{\"item\":\":coin\",\"denomination\":0.25},\"2\":{\"item\":\":coin\",\"denomination\":0.25},\"3\":{\"item\":\":die\",\"sides\":6,\"colour\":\"white\"},\"4\":{\"item\":\":die\",\"sides\":6,\"colour\":\"white\"},\"5\":{\"item\":\":die\",\"sides\":6,\"colour\":\"white\"}}"

        if @player.save
            redirect_to @player
        else
            render 'new'
        end
    end

    def destroy
        @player = Player.find(params[:id])
        @player.destroy
        redirect_to players_path
    end

    private
    def player_params
        params.require(:player).permit(:username, :password, :email)
    end

    private
    def sign_in
        @player = Player.find_by(email: player_params[:email])
        if @player && (@player.password == player_params[:password])
            # if player with this email exists, and password matches
            redirect_to @player # go to their User Page
        else
            # if not, they need to sign up
            render 'new'
        end
    end

end
