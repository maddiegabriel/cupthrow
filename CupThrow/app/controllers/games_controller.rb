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

        # throwing cup on table
        if params[:commit] == "Throw 1" || params[:commit] == "Throw 2" || params[:commit] == "Throw 3"
            throw_cup
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
        fill_bag_initial(p)
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
        rando = rand(1..10)
        # generate random descriptions of random number of coins
        # generate random descriptions of random number of dice
        # concatenate into string
        case rando
        when 1
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
                   "up":3
                }
             }'
        when 2
            return '{
                "scoring":"sum",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":6
                }
             }'
        when 3
            return '{
                "scoring":"tally",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                    "item":":coin",
                    "denomination":0.25,
                    "up":":H"
                 },
                "3":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":4
                },
                "4":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":5
                }
             }'
        when 4
            return '{
                "scoring":"sum",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                    "item":":coin",
                    "denomination":0.25,
                    "up":":H"
                 },
                 "3":{
                    "item":":coin",
                    "denomination":0.25,
                    "up":":H"
                 },
                "4":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":2
                },
                "5":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":5
                }
             }'
        when 5
            return '{
                "scoring":"sum",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                    "item":":coin",
                    "denomination":0.25,
                    "up":":H"
                 },
                 "3":{
                    "item":":coin",
                    "denomination":0.25,
                    "up":":H"
                 },
                "4":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":3
                },
                "5":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":6
                },
                "6":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":2
                }
             }'
        when 6
            return '{
                "scoring":"tally",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":3
                },
                "3":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":2
                },
                "4":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":1
                }
             }'
        when 7
            return '{
                "scoring":"sum",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                    "item":":coin",
                    "denomination":0.25,
                    "up":":H"
                 },
                "3":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":4
                },
                "4":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":1
                }
             }'
        when 8
            return '{
                "scoring":"tally",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
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
                   "up":4
                }up":4
                }
             }'
        when 9
            return '{
                "scoring":"tally",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":1
                }
             }'
        else
            return '{
                "scoring":"sum",
                "1":{
                   "item":":coin",
                   "denomination":0.25,
                   "up":":T"
                },
                "2":{
                   "item":":die",
                   "sides":6,
                   "colour":":white",
                   "up":1
                }
             }'
        end
    end

    private
    def load_cup()
        puts('LOADING PLAYER CUP FROM BAG')
        player = Player.find(params[:id])

        # make 3 copies of new gameplayer
        p1 = GamePlayer.new(player.username)
        p2 = GamePlayer.new(player.username)
        p3 = GamePlayer.new(player.username)

        # fill each bag with contents of bag_desc
        bag_json = JSON.parse(player.bag_desc)
        fill_bag(p1, bag_json)
        fill_bag(p2, bag_json)
        fill_bag(p3, bag_json)

        # load each cup with all items from bag
        p1.load({item: :coin})
        p1.load({item: :die})
        p2.load({item: :coin})
        p2.load({item: :die})
        p3.load({item: :coin})
        p3.load({item: :die})

        # empty player's bag since they loaded everything
        player.bag_desc = ""

        # generate 3 throws, store in player
        p1.throw
        p2.throw
        p3.throw
        
        # calculate scores (sum or tally) for each throw
        # score_throw1

        # store the highest score
    end

    private
    def throw_cup
        puts('THROWING PLAYER CUP')
        # just show the 3 scores
    end

    private
    def calc_score(desc)
        puts('CALCULATING SCORE...')
        4
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