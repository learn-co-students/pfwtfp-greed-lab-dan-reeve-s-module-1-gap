class Player

  def initialize(name = "Player")
    @name = name
    @score = 0
  end

  def name
    @name
  end

  def score
    @score
  end

  def add_to_score(points)
    @score += points
  end

end
