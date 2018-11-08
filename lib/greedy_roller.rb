require 'dice_roll'

class GreedyDiceRoller < DiceRoll
  def to_a
    @roll
  end

  def +(x)
    points + x
  end

  def points
    points = 0

    dice_hash = generate_set.each_with_object(Hash.new(0)) { |die, acc| acc[die] += 1 }

    dice_hash.keys.each do |key|
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
    end

    if dice_hash.keys.length == 3 && dice_hash.keys.none? {|key| dice_hash[key] != 2}
      points = 500
    elsif dice_hash.keys.length == 5
      points = 1000 if dice_hash.keys.min == 1 && dice_hash.keys.max == 5
      points = 1000 if dice_hash.keys.min == 2 && dice_hash.keys.max == 6
      points += 100 if dice_hash[1] == 2
      points += 50 if dice_hash[5] == 2
    elsif dice_hash.keys.length == 6
      points = 1500
    end

    points
  end
end
