class Player
  VERSION = 'Lazy bot'

  def bet_request(game_state)
    brain = PokerBrain.new
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
    2 => AgressivePlayStrategy,
    3 => AgressivePlayStrategy,
    4 => FoldStrategy,
    5 => FoldStrategy,
    6 => FoldStrategy,
  }

  attr_reader :game_state

  def initialzie(game_state)
    @game_state = game_state
  end

  def make_decision(game_state)
    game = Game.new(game_state)
    strategy = STRATEGIES[game.active_players_count.to_sym]
    strategy.execute(game_state)
  end
end

class InemOldStrategy
  def self.execute(game_state)
    players = game_state["players"]
    inem = players.select{|p| p["name"] == "inem"}

    cards = inem["hole_cards"]
    first,last = *cards.map{|c| c["rank"]}

    if first == last
      return 100000
    elsif first.to_i == 0 && second.to_i == 0
      return 100000
    else
      return 100000
    end

  end
end
