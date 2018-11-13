require 'spec_helper'

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

  describe 'winner' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:winner)
    end

    it "returns the first Player instance found with more than 10000 points" do
      greed = Greed.new()
      player1 = Player.new("Player 1")
      player1.instance_variable_set(:@score, 0)
      player2 = Player.new("Player 2")
      player2.instance_variable_set(:@score, 12000)
      greed.instance_variable_set(:@players, [player1, player2])

      expect(greed.winner).to eq(player2)


      player1.instance_variable_set(:@score, 10020)

      player2.instance_variable_set(:@score, 9000)
      greed.instance_variable_set(:@players, [player1, player2])

      expect(greed.winner).to eq(player1)

    end

  end

  describe 'read_integer' do
    it "exists" do
      greed = Greed.new()
      expect(greed).to respond_to(:read_integer)
    end

    it "receives user input and converts to integer" do
      greed = Greed.new()
      allow(greed).to receive(:gets) { "5" }
      expect(greed.read_integer).to eq(5)
    end
  end

  describe 'start_game' do
    original_stdout = $stdout
    greed = Greed.new()

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
      allow(greed).to receive(:prompt_player_count) { 2 }
      allow(greed).to receive(:play) { nil }

      expect(Message).to receive(:welcome)

      greed.start_game
    end

    it "calls `Message.greed`" do

      allow(greed).to receive(:prompt_player_count) { 2 }
      allow(greed).to receive(:play) { nil }

      expect(Message).to receive(:greed)
      greed.start_game
    end

    it "calls #play" do

      allow(greed).to receive(:prompt_player_count) { 2 }
      allow(greed).to receive(:play)

      expect(greed).to receive(:play).with(kind_of(Array))

      greed.start_game
    end

    it "populates the @players instance variable with Player objects" do
      allow(greed).to receive(:prompt_player_count) { 2 }
      allow(greed).to receive(:play)
      expect(greed.instance_variable_get(:@players)).to be_an(Array)
      expect(greed.instance_variable_get(:@players)).not_to be_empty

      greed.start_game
    end

    it "sets assigns numbers and scores to all Player instances " do
      allow(greed).to receive(:prompt_player_count) { 2 }
      allow(greed).to receive(:play)

      expect(greed.instance_variable_get(:@players).map {|player| player.score}).to eq([0,0])
      expect(greed.instance_variable_get(:@players).map {|player| player.id}).to eq(["Player 1", "Player 2"])
      greed.start_game
    end

  end


  describe 'play' do
    original_stdout = $stdout



    before(:all) do
       $stdout = File.open(File::NULL, "w")
    end

    after(:all) do
      $stdout = original_stdout
    end

    it 'calls `winner` if someone has won' do
      greed = Greed.new()
      player1 = Player.new("Player 1")
      player2 = Player.new("Player 2")


      allow(greed).to receive(:someone_won?) { true }
      allow(greed).to receive(:winner) { player1 }

      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed).to receive(:winner)

      greed.play(greed.instance_variable_get(:@players))
    end

    it 'calls `take_turn` for if there is no current winner' do
      greed = Greed.new()
      player1 = Player.new("Player 1")
      player2 = Player.new("Player 2")

      allow(greed).to receive(:someone_won?).and_return(false, true)
      allow(greed).to receive(:take_turn)
      allow(greed).to receive(:winner) { player1 }

      greed.instance_variable_set(:@players, [player1, player2])
      expect(greed).to receive(:take_turn)

      greed.play(greed.instance_variable_get(:@players))
    end

  end
end
