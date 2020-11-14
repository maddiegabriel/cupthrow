require_relative 'Maddie/GamePlayer.rb'
require_relative 'Maddie/RandomizerFactory.rb'

class GamesController < ApplicationController
    def create
        puts('inside gamecontroller create')

        # loading cup from bag
        if params[:commit] == "Load"
            load_cup
            return
        end

        @game = Game.new

        # define the player in this game
        @game.player_id = game_params[:id]
        @current_player = Player.find(game_params[:id])

        # select random goal for this game
        @game.goal_description = random_goal

        # initialize scores for this game
        @game.player_score = 0
        @game.server_score = 0
        @game.goal_score = calc_score(@game.goal_description)

        # create actual ruby Player for the game and fill starting Bag
        p = GamePlayer.new(@current_player.username)
        fill_bag(p)
        puts("HERE IS THE BAG")
        puts(p.print_bag)
        @current_player.bag_desc = p.print_bag

        # save game in db and go to play game page
        @game.save

        redirect_to @game
    end

    def index
        @game = Game.all
    end

    def new
        @game = Game.new
    end

    def show
        @game = Game.find(params[:id])
        render 'new'
    end

    private
    def game_params
        params.permit(:id)
    end

    private
    def random_goal
        # generate random tally OR sum
        # generate random descriptions of random number of coins
        # generate random descriptions of random number of dice
        # concatenate into string like {{}}
        return '{
            "scoring":"tally",
            "1":{
               "item":":coin",
               "denomination":0.25,
               "up":":H"
            },
            "2":{
               "item":":die",
               "sides":6,
               "colour":":white",
               "up":4
            },
            "3":{
               "item":":die",
               "sides":6,
               "colour":":white",
               "up":5
            }
         }'
    end

    private
    def fill_bag(game_player)
        # provided with three quarters and three six-sided white dice
        factory = RandomizerFactory.new()
        game_player.store(factory.create_coin(0.25))
        game_player.store(factory.create_coin(0.25))
        game_player.store(factory.create_coin(0.25))
        game_player.store(factory.create_die(6, :white))
        game_player.store(factory.create_die(6, :white))
        game_player.store(factory.create_die(6, :white))
    end

    private
    def load_cup
        puts('LOADING PLAYER CUP FROM BAG')
    end

    private
    def throw_cup
        puts('THROWING PLAYER CUP')
    end

    private
    def calc_score(desc)
        puts('CALCULATING SCORE...')
        4
    end
end