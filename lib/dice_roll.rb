class DiceRoll
  attr_reader :dice_count, :dice

  def initialize(dice_count = 1, pips_count=6, hard_set=[])
    @dice_count = dice_count
    @pips_count = pips_count

    @dice = hard_set.empty? ?
      Array.new(@dice_count) { Die.new(@pips_count) } :
      Array.new(hard_set.count) { |i| Die.new(@pips_count, hard_set[i]) }
  end

  def length
    @roll.length
  end

  def dice_values
    dice.map(&:roll)
  end

  def generate_set
    @roll ||= @dice.map{ |d| d.roll }
  end

  def delete_at(i)
    raise RangeError, "#{i} is out of range to 0..#{length - 1}" if !(0..length-1).include?(i)
    @roll.delete_at(i)
  end

  def fresh_roller
    self.class.new(dice_count, pips_count)
  end

  def refill!
    return if dice_count == @roll.length
    @roll += Array.new(dice_count - @roll.length){ |i| Die.new(@pips_count) }
  end
end
