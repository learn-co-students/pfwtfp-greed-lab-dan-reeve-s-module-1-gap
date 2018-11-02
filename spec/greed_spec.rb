require 'spec_helper'
require 'pry'
require 'pry-rescue'
require_relative '../lib/message.rb'
require_relative '../lib/greed.rb'
require_relative '../lib/player.rb'

describe 'Player' do
  describe '.new(player_name)' do
    it "creates a new instance of Player" do
      expect{ Player.new("Steve") }.not_to raise_error
    end

    it "creates an @name instance variable and assigns it to the input" do
      player = Player.new("Steve")
      expect(player.instance_variable_get(:@name)).to eq("Steve")
    end

    it "creates an @players instance variable and assigns it an empty Array" do
      player = Player.new("Steve")
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

  describe 'roll_dice(number)' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:roll_dice)
    end

    it "returns an Array of integers between 1 and 6" do
      greed = Greed.new()
      (1..6).each {|number|
        results = greed.roll_dice(number)
        expect(results.length).to eq(number)
        expect(results).to all(be_an(Integer))
        expect(results).to all(be < 7) & all(be > 0)
      }
    end
  end

  describe 'players' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:players)
    end

    it "returns an Array of player instances" do
      greed = Greed.new()
      player1 = Player.new("Steve")
      player2 = Player.new("Martin")
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
      player1 = Player.new("Steve")
      player1.instance_variable_set(:@score, 3000)
      player2 = Player.new("Martin")
      player2.instance_variable_set(:@score, 10000)
      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed.winner?).to eq(true)
    end

    it "returns `false` if no player has 10000 points or more" do
      greed = Greed.new()

      player1 = Player.new("Steve")
      player1.instance_variable_set(:@score, 3000)
      player2 = Player.new("Martin")
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
      allow(greed).to receive(:get_input) { "2" }
      allow(greed).to receive(:setup_game) { nil }

      expect(Message).to receive(:welcome)
      greed.start_game
    end

    it "calls `Message.greed`" do
      allow(greed).to receive(:get_input) { "2" }
      allow(greed).to receive(:setup_game) { nil }

      expect(Message).to receive(:greed)
      greed.start_game
    end

    it "calls `setup_game`" do

      allow(greed).to receive(:get_input) { "2" }
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
      allow(greed).to receive(:get_input) { "2" }
      allow(greed).to receive(:play_game) { nil }
      greed.instance_variable_set(@players, [Player.new("Steve"), Player.new("Martin")])

      expect(Message).to receive(:number_of_players)
      
      greed.setup_game
    end

    it "calls `play_game`" do
      allow(greed).to receive(:get_input) { "2" }
      allow(greed).to receive(:play_game) { nil }
      greed.instance_variable_set(@players, [Player.new("Steve"), Player.new("Martin")])
      expect(greed).to receive(:play_game)
      expect(Message).to receive(:welcome)
      expect(Message).to receive(:greed)
      greed.setup_game
    end
    it "calls `play_game`" do
      allow(greed).to receive(:get_input) { "2" }
      allow(greed).to receive(:play_game) { nil }
      greed.instance_variable_set(@players, [Player.new("Steve"), Player.new("Martin")])
      expect(greed).to receive(:play_game)
      expect(Message).to receive(:welcome)
      expect(Message).to receive(:greed)
      greed.setup_game
    end
  end

  describe 'opening_prompt' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:opening_prompt)
    end
  end

  describe 'take_turn(player)' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:opening_prompt)
    end
  end



  describe 'calculate_points' do

  end
end
