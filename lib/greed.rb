require 'pry'

require_relative 'message'
require_relative 'player'
require_relative 'dice_roll'
require_relative 'greedy_roller'

class Greed

  attr_accessor :players

  def initialize()
    # @opts = opts
  end

  def start_game
    Message.welcome
    Message.greed

    begin
      player_count = prompt_player_count
    rescue ArgumentError
      Message.invalid_entry
      start_game
    end

    @players = Array.new(player_count){ |i| Player.new("Player #{i+1}") }

    play(@players)

  end

  def prompt_player_count
    Message.number_of_players
    inp = read_integer
    if !(2..6).include?(inp)
      raise ArgumentError, "The count of players should be between 2 and 6"
    end
    inp
  end

  def play(players)
    while !someone_won? do
      players.each_with_index do |player|
        display_scores(players)
        take_turn(player)
        break if someone_won?
      end
    end
    puts "#{winner.id} wins!"
  end

  def display_scores(players)
    Message.current_scores(players)
  end

  def take_turn(player, current_roll = GreedyDiceRoller.new(6))
    Message.current_player_turn(player)
    Message.saved_dice(current_roll)
    Message.roll_results(player, current_roll)

    if current_roll.points == 0
      Message.greed
      end_turn(player, 0)
      return
    end

    present_user_choice(player, current_roll)
  end

  def present_user_choice(player, roll)
    Message.roll_options(roll.points)
    choice = read_integer
    case choice
    when 1
      end_turn(player, roll.points)
    when 2
      take_turn(player)
    when 3
      Message.current_scores(players)
      Message.saved_dice(roll)
      roll = select_reroll(roll)
      roll.refill!
      take_turn(player, roll)
    end
  end

  def select_reroll(r)
    while r.length >= 0 do
      Message.select_reroll_dice(r.generate_set)
      choice = read_integer
      return r if choice.to_i == (r.length + 1)
      begin
        r.delete_at(choice - 1)
      rescue RangeError => e
        STDERR.puts(e.message)
        Message.invalid_entry
      end
    end
  end

  def end_turn(player, points)
    player.score += points
    Message.end_turn(player, points)
    read_integer
  end

  def winner
    @players.find {|player| player.score >= 10000}
  end

  def someone_won?
    !!winner
  end

  def read_integer
    gets.chomp.strip.to_i
  end
end
