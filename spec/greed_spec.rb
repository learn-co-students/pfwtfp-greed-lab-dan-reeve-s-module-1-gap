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

  describe 'someone_won?' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:someone_won?)
    end

    it "returns `true` if a player has 10000 points or more" do
      greed = Greed.new()
      player1 = Player.new(1)
      player1.instance_variable_set(:@score, 3000)
      player2 = Player.new(2)
      player2.instance_variable_set(:@score, 10000)
      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed.someone_won?).to eq(true)
    end

    it "returns `false` if no player has 10000 points or more" do
      greed = Greed.new()

      player1 = Player.new(1)
      player1.instance_variable_set(:@score, 3000)
      player2 = Player.new(2)
      player2.instance_variable_set(:@score, 9000)
      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed.someone_won?).to eq(false)
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
    original_stdout = $stdout
    greed = Greed.new(test_mode: true)

    before(:all) do
       $stdout = File.open(File::NULL, "w")
    end

    after(:all) do
      $stdout = original_stdout
    end

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
      allow(greed).to receive(:read_integer) { 2 }

      expect(Message).to receive(:greed)
      greed.start_game
    end
  end


end
