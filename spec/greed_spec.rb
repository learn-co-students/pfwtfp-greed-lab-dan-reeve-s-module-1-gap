require 'spec_helper'
require 'pry'
require 'pry-rescue'
require_relative '../lib/message.rb'
require_relative '../lib/greed.rb'
require_relative '../lib/player.rb'

describe 'Player' do
  describe '.new(player_name)' do
    it "creates a new instance of Player" do
      expect{ Player.new(1) }.not_to raise_error
    end

    it "creates an @name instance variable and assigns it to the input" do
      player = Player.new(1)
      expect(player.instance_variable_get(:@id)).to eq(1)
    end

    it "creates an @players instance variable and assigns it an empty Array" do
      player = Player.new(1)
      expect(player.instance_variable_get(:@score)).to eq(0)
    end
  end
end


describe 'Greed' do

  describe '.new()' do
    it "creates a new instance of Greed" do
      expect{ Greed.new() }.not_to raise_error
    end
  end

  describe 'players' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:players)
    end

    it "returns an Array of player instances" do
      greed = Greed.new()
      player1 = Player.new(1)
      player2 = Player.new(2)
      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed.players).to be_an(Array)
      expect(greed.players).to eq([player1, player2])
    end
  end

  describe 'winner?' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:winner?)
    end

    it "returns `true` if a player has 10000 points or more" do
      greed = Greed.new()
      player1 = Player.new(1)
      player1.instance_variable_set(:@score, 3000)
      player2 = Player.new(2)
      player2.instance_variable_set(:@score, 10000)
      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed.winner?).to eq(true)
    end

    it "returns `false` if no player has 10000 points or more" do
      greed = Greed.new()

      player1 = Player.new(1)
      player1.instance_variable_set(:@score, 3000)
      player2 = Player.new(2)
      player2.instance_variable_set(:@score, 9000)
      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed.winner?).to eq(false)
    end

  end

  describe 'get_input' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:get_input)
    end

    it "receives user input and converts to integer" do
      greed = Greed.new()
      allow(greed).to receive(:gets) { "5" }
      expect(greed.get_input).to eq(5)
    end
  end

  describe 'start_game' do

    greed = Greed.new()

    it "exists" do
      expect(greed).to respond_to(:start_game)
    end

    it "calls `Message.welcome`" do
      allow_any_instance_of(Object).to receive(:puts) { "" }
      allow(greed).to receive(:get_input) { 2 }
      allow(greed).to receive(:setup_game) { nil }

      expect(Message).to receive(:welcome)
      greed.start_game
    end

    it "calls `Message.greed`" do
      allow_any_instance_of(Object).to receive(:puts) { "" }
      allow(greed).to receive(:get_input) { 2 }
      allow(greed).to receive(:setup_game) { nil }

      expect(Message).to receive(:greed)
      greed.start_game
    end

    it "calls `setup_game`" do
      allow_any_instance_of(Object).to receive(:puts) { "" }
      allow(greed).to receive(:get_input) { 2 }
      allow(greed).to receive(:setup_game) { nil }

      expect(greed).to receive(:setup_game)
      greed.start_game
    end
  end

  describe 'setup_game' do
    greed = Greed.new()

    it "exists" do
      expect(greed).to respond_to(:setup_game)
    end

    it "calls `Message.number_of_players`" do
      allow(greed).to receive(:get_input) { 2 }
      allow(greed).to receive(:play_game) { nil }
      greed.instance_variable_set(:@players, [Player.new(1), Player.new(2)])

      expect(Message).to receive(:number_of_players)

      greed.setup_game
    end

    it "calls `play_game`" do
        allow(greed).to receive(:get_input) { 2 }
        allow(greed).to receive(:play_game) { nil }
        greed.instance_variable_set(:@players, [Player.new(1), Player.new(2)])
        expect(greed).to receive(:play_game)

        greed.setup_game
      end
  end

  describe "calculate_points" do
    greed = Greed.new()

    it "exists" do
      expect(greed).to respond_to(:calculate_points)
    end

    it "takes in an any array of integers and returns a point value" do
      expect(greed.calculate_points([1])).to be_an(Integer)
      expect(greed.calculate_points([3,3])).to be_an(Integer)
      expect(greed.calculate_points([4,2,3])).to be_an(Integer)
      expect(greed.calculate_points([5,5,5,5,5])).to be_an(Integer)
      expect(greed.calculate_points([6,1,1,1,1,1])).to be_an(Integer)
    end

    it "accurately calculates points based on the number of 1s rolled" do
      expect(greed.calculate_points([1])).to eq(100)
      expect(greed.calculate_points([4,2,3,1,3,4])).to eq(100)
      expect(greed.calculate_points([1,2,1])).to eq(200)
      expect(greed.calculate_points([1,2,1,2,1])).to eq(1000)
      expect(greed.calculate_points([1,1,1,2,1])).to eq(2000)
      expect(greed.calculate_points([1,1,1,2,1,1])).to eq(4000)
      expect(greed.calculate_points([1,1,1,1,1,1])).to eq(8000)
    end

    it "accurately calculates points based on the number of 5s rolled" do
      expect(greed.calculate_points([5])).to eq(50)
      expect(greed.calculate_points([4,2,3,5,3,4])).to eq(50)
      expect(greed.calculate_points([5,2,5])).to eq(100)
      expect(greed.calculate_points([5,2,5,2,5])).to eq(500)
      expect(greed.calculate_points([5,5,5,2,5])).to eq(1000)
      expect(greed.calculate_points([5,5,5,2,5,5])).to eq(2000)
      expect(greed.calculate_points([5,5,5,5,5,5])).to eq(4000)
    end

    it "accurately calculates points for more than three of any number other than 1" do
      expect(greed.calculate_points([2,2,2])).to eq(200)
      expect(greed.calculate_points([3,2,3,4,3,4])).to eq(300)
      expect(greed.calculate_points([4,4,4,2])).to eq(400)
      expect(greed.calculate_points([2,2,2,2,5])).to eq(450)
      expect(greed.calculate_points([3,3,3,3,3])).to eq(1200)
      expect(greed.calculate_points([4,4,4,2,4,4])).to eq(1600)
      expect(greed.calculate_points([3,3,3,3,3,3])).to eq(2400)
      expect(greed.calculate_points([4,4,4,4,4,4])).to eq(3200)
      expect(greed.calculate_points([6,6,6,6,6,6])).to eq(4800)
    end

    it "accurately calculates points for any combination of 5s and 1s rolled" do
      expect(greed.calculate_points([5,1])).to eq(150)
      expect(greed.calculate_points([4,1,3,5,3,4])).to eq(150)
      expect(greed.calculate_points([5,1,1])).to eq(250)
      expect(greed.calculate_points([5,1,5,1,5])).to eq(700)
      expect(greed.calculate_points([5,1,5,5,5])).to eq(1100)
      expect(greed.calculate_points([1,1,1,5,6])).to eq(1050)
      expect(greed.calculate_points([5,5,5,5,1,5])).to eq(2100)
    end

    it "accurately calculates points for combinations of multiples, 5s and 1s" do
      expect(greed.calculate_points([5,1,3,3,3])).to eq(450)
      expect(greed.calculate_points([4,1,4,5,3,4])).to eq(550)
      expect(greed.calculate_points([5,1,1,2,2,2])).to eq(450)
      expect(greed.calculate_points([5,1,5,1,5])).to eq(700)
      expect(greed.calculate_points([5,1,5,5,5])).to eq(1100)
      expect(greed.calculate_points([1,1,1,5,6])).to eq(1050)
      expect(greed.calculate_points([5,5,5,5,1,5])).to eq(2100)
    end

    it "accurately calculates points for three pairs" do
      expect(greed.calculate_points([2,2,3,3,4,4])).to eq(500)
      expect(greed.calculate_points([1,1,3,3,4,4])).to eq(500)
    end

    it "accurately calculates points for a 5 dice straight" do
      expect(greed.calculate_points([1,2,3,4,5])).to eq(1000)
      expect(greed.calculate_points([2,3,4,5,6])).to eq(1000)
      expect(greed.calculate_points([1,2,3,4,5,3])).to eq(1000)
      expect(greed.calculate_points([3,2,3,4,5,6])).to eq(1000)
      expect(greed.calculate_points([5,2,3,4,5,6])).to eq(1050)
      expect(greed.calculate_points([1,2,3,4,5,1])).to eq(1100)
    end

    it "accurately calculates points for a 6 dice straight" do
      expect(greed.calculate_points([1,2,3,4,5,6])).to eq(1500)
    end





  end

end
