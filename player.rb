class Player
  VERSION = 'Lazy bot'

  def bet_request(game_state)
    brain = PokerBrain.new(game_state)
    brain.make_decision(game_state)
  rescue => e
    puts e
    InemOldStrategy.execute(game_state)
  end

  def showdown(game_state)

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

class InemOldStrategy
  def self.execute(game_state)
    rand(100)+200
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
