require 'spec_helper'
require 'pry'
require 'pry-rescue'
require_relative '../lib/message.rb'
require_relative '../lib/greed.rb'
require_relative '../lib/player.rb'

def capture_stdout(&blk)
  old = $stdout
  $stdout = fake = StringIO.new
  blk.call
  fake.string
ensure
  $stdout = old
end

describe 'Greed' do

  it 'starts a new game with Greed.start_game' do
    # Object.any_instance.stub(puts: "")
    # binding.pry
    greed = Greed.new()
    allow(greed).to receive(:get_number_of_players) { 2 }
    allow(greed).to receive(:get_turn_decision) { 1 }
    allow(greed).to receive(:press_enter_for_next_turn) { "" }
    allow(greed).to receive(:press_enter_for_next_turn) { "" }
    allow(greed).to receive(:roll_dice) { [1,1,1,1,1,1]}
    printed = capture_stdout do
      greed.start_game
    end
    # $stdout = StringIO.new
    binding.pry
    expect(1).to eq(1)

    printed.should eq("my message")

    #

binding.pry
expect(1).to eq(1)
  # (0.1 + 0.2).should == 0.3
  #
  #   $stdout.rewind



    # expect(greed).to have_received(:get_number_of_players)
    # expect(greed).to have_received(:get_turn_decision)
    # expect(greed).to have_received(:press_enter_for_next_turn)

    # expect(Greed.new()).to receive(:get_number_of_player)
  end

  it "text" do
    # Object.any_instance.stub(gets: "1")
    # Object.any_instance.stub(puts: "")
    # Greed.instance_variable_set(:@player_count, 2)
    #
    # expect(Message).to receive(:welcom)
    # expect(Message).to receive(:greed)
    # expect(Message).to receive(:number_of_players)

  end


  describe 'calculate_points' do

  end
end
