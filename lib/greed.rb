require 'pry'

require_relative 'message'
require_relative 'player'
require_relative 'dice_roll'

class Greed
  attr_accessor :players, :player_count, :current_player, :current_roll, :current_roll_points, :saved_dice_roll_array, :saved_dice_points

  def initialize
    self.players = []
  end

  def start_game
    Message.welcome
    Message.greed
    setup_game
  end

  def setup_game

    Message.number_of_players
    self.player_count = get_input
    if (2..6).include? self.player_count

      self.player_count.times do |i|
        self.players << Player.new("Player #{i+1}")
      end

      play_game
    else
      Message.invalid_entry
      setup_game
    end
  end

  def play_game

    self.players.each_with_index {|player|
      self.current_player = player
      self.saved_dice_roll_array = []
      take_turn
      return if winner?
    }
    winner = self.players.sort {|player| player.score}.first
    Message.winner(winner)
    play_game
  end


  def take_turn
    Message.current_scores(self.players)
    Message.current_player_turn(self.current_player)

    # roll dice
    self.current_roll = DiceRoll.new(6 - self.saved_dice_roll_array.flatten.length)

    # calculate point value of roll
    self.current_roll_points = calculate_points(self.current_roll.generate_set)
    self.saved_dice_points = self.saved_dice_roll_array.reduce(0) {|sum, roll| sum += calculate_points(roll)}

    Message.saved_dice(self.saved_dice_roll_array, self.saved_dice_points)
    Message.roll_results(self.current_player, self.current_roll.generate_set, self.current_roll_points)

    # if @roll_points == 0, display Greed message and end turn, else display results
    if self.current_roll_points == 0
      Message.greed
      end_turn(0)
    else
      Message.roll_options(self.current_roll_points + self.saved_dice_points)
      get_player_choice
    end
  end

  def end_turn(points)
    # display current_scores, roll_results and end_turn from Message
    self.current_player.score += points
    Message.end_turn(self.current_player, points)
    get_input
  end

  def get_player_choice
    choice = get_input
    case choice
    when 1
      points_from_saved_dice = self.saved_dice_roll_array.reduce(0) {|sum, roll| sum += calculate_points(roll)}
      total_points = self.current_roll_points + self.saved_dice_points
      end_turn(total_points)
    when 2
      take_turn
    when 3
      save_dice_and_reroll
    else
      Message.invalid_entry
      get_player_choice
    end
  end


  def save_dice_and_reroll(new_dice_array = [])

    temporary_dice_display = self.saved_dice_roll_array + [new_dice_array]
    temporary_points = temporary_dice_display.reduce(0) {|sum, roll| sum += calculate_points(roll)}

    Message.current_scores(self.players)
    Message.saved_dice(temporary_dice_display, temporary_points)
    Message.select_reroll_dice(self.current_roll.generate_set)

    choice = get_input
    if (1..self.current_roll.dice.length).include? choice

      new_dice_array.push(self.current_roll.dice.delete_at(choice-1).roll)
      save_dice_and_reroll(new_dice_array)

    else
      self.saved_dice_roll_array.push(new_dice_array) if !new_dice_array.empty?
      take_turn
    end
  end

  def calculate_points(dice_roll)
    points = 0

    dice_hash = dice_roll.each_with_object(Hash.new(0)) { |die, acc| acc[die] += 1 }

    dice_hash.keys.each {|key|
      case dice_hash[key]
      when 1..2
        if key == 1
          points += 100 * dice_hash[key]
        elsif key == 5
          points += 50 * dice_hash[key]
        end
      when 3
        if key == 1
          points += 1000
        else
          points += key*100
        end
      when 4
        if key == 1
          points += 2000
        else
          points += key*200
        end
      when 5
        if key == 1
          points += 4000
        else
          points += key*400
        end
      when 6
        if key == 1
          points += 8000
        else
          points += key*800
        end
      end
    }
    if dice_hash.keys.length == 3 && dice_hash.keys.none? {|key| dice_hash[key] != 2}
      points = 500
    elsif dice_hash.keys == [1,2,3,4,5] || dice_hash.keys == [2,3,4,5,6]
      points = 1000
    elsif dice_hash.keys.length == 6
      points = 1500
    end

    points
  end

  def winner?
    !!self.players.find {|player| player.score >= 10000}
  end

  def get_input
    gets.chomp.strip.to_i
  end

end
