#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'die'
require 'dice_roll'
require 'greedy_roller'
require 'greed'
require 'player'


Greed.new().start_game
