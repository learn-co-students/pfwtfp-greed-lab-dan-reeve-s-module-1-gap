class Die
  # The number of dots on a die are called "pips"
  attr_reader :max_pips, :roll

  def initialize(max_pips=6, set_value=nil)
    @max_pips = max_pips
    @set_value = set_value
  end

  def roll
    return @set_value if @set_value
    @roll ||= rand(max_pips) + 1
  end
end
