class Player
  VERSION = 'Lazy bott'

  def bet_request(game_state)
    brain = PokerBrain.new(game_state)
    brain.make_decision(game_state)
  rescue
    10000
  end

  def showdown(game_state)

  end
end

class InemOldStrategy
  def self.execute(game_state)
    players = game_state["players"]
    inem = players.select{|p| p["name"] == "inem"}

    cards = inem["hole_cards"]
    first,last = *cards.map{|c| c["rank"]}

    # pair
    if first == last
      return 100000
    # 2 pictures
    elsif first.to_i == 0 && second.to_i == 0
      return 600
    # 1 picture
    else first.to_i == 0 || second.to_i == 0
      return 400
    else
      return 0
    end

  end
end

class AgressivePlayStrategy
  def self.execute(game_state)
    1000000
  end
end

class FoldStrategy
  def self.execute(game_state)
    0
  end
end

class PokerBrain
  STRATEGIES = {
    2 => InemOldStrategy,
    3 => InemOldStrategy,
    4 => InemOldStrategy,
    5 => InemOldStrategy,
    6 => InemOldStrategy,
    # 2 => AgressivePlayStrategy,
    # 3 => AgressivePlayStrategy,
    # 4 => FoldStrategy,
    # 5 => FoldStrategy,
    # 6 => FoldStrategy,
  }

  attr_reader :game_state

  def initialzie(game_state)
    @game_state = game_state
  end

  def make_decision(game_state)
    game = Game.new(game_state)
    strategy = STRATEGIES[game.active_players_count]
    strategy.execute(game_state)
  end
end

class Game
  attr_reader :game_state

  def initialzie(game_state)
    @game_state = game_state
  end

  def active_players_count
    6
  end
end
