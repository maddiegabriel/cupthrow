require_relative 'Maddie/GamePlayer.rb'
require_relative 'Maddie/RandomizerFactory.rb'

class GamesController < ApplicationController
    def create

        # loading cup from bag
        if params[:commit] == "Load"
            load_cup
            game = Game.find(params[:game_id])
            redirect_to game
            return
        end

        # throwing cup on table
        if params[:commit] == "Throw 1" || params[:commit] == "Throw 2" || params[:commit] == "Throw 3"
            player = Player.find(params[:id])
            player.gems = player.gems + 1
            player.save
            game = Game.find(params[:game_id])
            redirect_to game
            return
        end

        # create the game
        @game = Game.new

        # define the player in this game
        @game.player_id = game_params[:id]
        @current_player = Player.find(game_params[:id])
        @current_player.gems = 0
        # select random goal for this game
        @game.goal_description = random_goal

        # initialize scores for this game
        @game.player_score = 0
        @game.server_score = 0
        @game.goal_score = calc_score(@game.goal_description)

        # create actual ruby GamePlayer for the game and fill default Bag
        p = GamePlayer.new(@current_player.username)
        fill_bag_initial(p)
        @current_player.bag_desc = p.print_bag

        # save game in db and go to play game page
        @game.save
        @current_player.save
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
        rando = rand(1..10)

        # choose random descriptions of random number of coins/dice
        # adjusted to only allow limited hardcoded combos since i did not implement "purchase items" page
        case rando
        when 1
            return '{"scoring":"tally","2":{"item":":die","sides":6,"colour":":white","up":4},"3":{"item":":die","sides":6,"colour":":white","up":3}}'
        when 2
            return '{"scoring":"sum","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":die","sides":6,"colour":":white","up":6}}'
        when 3
            return '{"scoring":"tally","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":coin","denomination":0.25,"up":":H"},"3":{"item":":die","sides":6,"colour":":white","up":4},"4":{"item":":die","sides":6,"colour":":white","up":5}}'
        when 4
            return '{"scoring":"sum","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":coin","denomination":0.25,"up":":H"},"3":{"item":":coin","denomination":0.25,"up":":H"},"4":{"item":":die","sides":6,"colour":":white","up":2},"5":{"item":":die","sides":6,"colour":":white","up":5}}'
        when 5
            return '{"scoring":"sum","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":coin","denomination":0.25,"up":":H"},"3":{"item":":coin","denomination":0.25,"up":":H"},"4":{"item":":die","sides":6,"colour":":white","up":3},"5":{"item":":die","sides":6,"colour":":white","up":6},"6":{"item":":die","sides":6,"colour":":white","up":2}}'
        when 6
            return '{"scoring":"tally","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":die","sides":6,"colour":":white","up":3},"3":{"item":":die","sides":6,"colour":":white","up":2},"4":{"item":":die","sides":6,"colour":":white","up":1}}'
        when 7
            return '{"scoring":"sum","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":coin","denomination":0.25,"up":":H"}}'
        when 8
            return '{"scoring":"tally","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":die","sides":6,"colour":":white","up":4},"3":{"item":":die","sides":6,"colour":":white","up":4}}'
        when 9
            return '{"scoring":"tally","1":{"item":":coin","denomination":0.25,"up":":T"},"2":{"item":":die","sides":6,"colour":":white"}}'
        else
            return '{"scoring":"sum","1":{"item":":coin","denomination":0.25,"up":":T"}}'
        end
    end

    private
    def load_cup()
        # define instances
        player = Player.find(params[:id])
        game = Game.find(params[:game_id])

        # make 3 copies of new gameplayer, and a server player
        p1 = GamePlayer.new(player.username)
        p2 = GamePlayer.new(player.username)
        p3 = GamePlayer.new(player.username)
        server = GamePlayer.new(player.username)

        # fill each bag with contents of bag_desc
        bag_json = JSON.parse(player.bag_desc)
        fill_bag(p1, bag_json)
        fill_bag(p2, bag_json)
        fill_bag(p3, bag_json)

        # TODO :: randomize server bag
        server_bag = "{
            \"3\":{
               \"item\":\":die\",
               \"sides\":5,
               \"colour\":\"white\"
            },
            \"5\":{
               \"item\":\":die\",
               \"sides\":6,
               \"colour\":\"white\"
            }
        }"
        server_bag_json = JSON.parse(player.bag_desc)
        fill_bag(server, server_bag_json)

        # load each cup with all items from bag
        p1.load({item: :coin})
        p1.load({item: :die})
        p2.load({item: :coin})
        p2.load({item: :die})
        p3.load({item: :coin})
        p3.load({item: :die})
        server.load({item: :coin})
        server.load({item: :die})

        # generate 3 player throws and server throw, store in player
        throw1 = p1.throw
        throw2 = p2.throw
        throw3 = p3.throw
        serverthrow = server.throw
        player.throw_desc = "{ \"throw1\": #{p1.print_throw},\"throw2\": #{p2.print_throw},\"throw3\": #{p3.print_throw}}"

        # score the throws
        throw1_score = p1.sum({item: :die}) + p1.sum({item: :coin})
        throw2_score = p2.sum({item: :die}) + p2.sum({item: :coin})
        throw3_score = p3.sum({item: :die}) + p3.sum({item: :coin})
        server_score = server.sum({item: :die}) + server.sum({item: :coin})

        # store the scores in game instance to show in view
        game.server_throw = "{ \"throw1\": #{throw1_score[0]},\"throw2\": #{throw2_score[0]},\"throw3\": #{throw3_score[0]}}"
        game.player_score = [throw1_score[0], throw2_score[0], throw3_score[0]].max
        game.server_score = server_score[0]
        player.points = player.points + game.player_score
        player.gems = player.gems + 1
        game.save
        player.save
    end

    private
    def calc_score(desc)
        # decided to randomize goal score in my game for simplicity
        rand(1..15)
    end

    private
    def fill_bag_initial(game_player)
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
    def fill_bag(game_player, bag)
        # provided with three quarters and three six-sided white dice
        factory = RandomizerFactory.new()
        bag.each do |key,value|
            if value['item'] == ':coin'
                game_player.store(factory.create_coin(value['denomination']))
            else
                game_player.store(factory.create_die(value['sides'], value['colour']))
            end
        end
    end
end