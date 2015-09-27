class Player
  VERSION = 'Lazy bott'

  def bet_request(game_state)
    brain = PokerBrain.new(game_state)
    brain.make_decision(game_state)
  rescue => e
    puts "Exception happened"
    puts "-----------------"
    puts e
    puts e.backtrace
    puts "-----------------"

    10000
  end

  def showdown(game_state)

  end
end

class InemOldStrategy
  def self.execute(game)
    cards = *game.our_cards

    # pair
    if pair?(cards)
      return 100000
    elsif first.to_i == 0
      # 2 pictures
      if last.to_i == 0
        puts "[2]"
        return 10000
      else
      # 1 picture
        if last.to_i > 7
          puts "[3]"
          return 10000
        end
      end
    end

    return 0
  end
  
  def both_pictures?(cards)
    first, last = *cards
    first.to_i == 0 && last.to_i == 0
  end

  def pair?(cards)
    first, last = *cards
    first == last
  end
end

class AgressivePlayStrategy
  def self.execute(game_state)
    1000000
  end
end

class FoldStrategy
  def self.execute(game)
    0
  end
end

class SmartFoldStrategy
  def self.execute(game)
    cards = *game.our_cards

    if both_pictures?(cards)
      100000
    elsif pair?(cards) && cards.first.to_i > 9
      100000
    else
      0
    end
  end

  def both_pictures?(cards)
    first, last = *cards
    first.to_i == 0 && last.to_i == 0
  end

  def pair?(cards)
    first, last = *cards
    first == last
  end
end

class PokerBrain
  STRATEGIES = {
    0 => InemOldStrategy,
    1 => InemOldStrategy,
    2 => InemOldStrategy,
    3 => InemOldStrategy,
    4 => SmartFoldStrategy,
    5 => SmartFoldStrategy,
    6 => SmartFoldStrategy,
    # 2 => AgressivePlayStrategy,
    # 3 => AgressivePlayStrategy,
    # 4 => FoldStrategy,
    # 5 => FoldStrategy,
    # 6 => FoldStrategy,
  }

  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
  end

  def make_decision(game_state)
    game = Game.new(game_state)

    puts "#{game.players}"
    puts "#{game.active_players_count}"

    strategy = STRATEGIES[game.active_players_count]
    
    puts "Selected Strategy: #{strategy}"
    puts "OUR PLAYER:"
    puts game.our_player
    puts "______"

    strategy.execute(game)
  end
end

class Game
  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
  end

  def players
    game_state['players']
  end

  def active_players
    players.select do |player|
      player['status'] == 'active'
    end
  end

  def active_players_count
    active_players.count
  end

  def our_player
    players.select { |p| p["name"] == "inem" }.first
  end

  def our_cards
    cards = our_player["hole_cards"]
    cards.map { |c| c["rank"] }
  end
end
