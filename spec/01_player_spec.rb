require 'spec_helper'


describe 'Player' do
  describe '.new(player_name)' do
    it "creates a new instance of Player" do
      expect{ Player.new(1) }.not_to raise_error
    end

    it "creates an @id instance variable and assigns it to the input when initialized" do
      player = Player.new(1)
      expect(player.instance_variable_get(:@id)).to eq(1)
      player2 = Player.new("Mike")
      expect(player2.instance_variable_get(:@id)).to eq("Mike")
    end

    it "creates an @score instance variable and sets it to zero when initialized" do
      player = Player.new(1)
      expect(player.instance_variable_get(:@score)).to eq(0)
    end
  end
end
