require 'spec_helper'

describe "GreedyDiceRoller" do
  describe "#calculate_points" do
    context "returns the correct type" do
      it "for sample 1" do
        test = [1]
        expect(GreedyDiceRoller.new(test.length, 6, test).points).to be_an(Integer)
      end
      it "for sample 2" do
        test = [3,3]
        expect(GreedyDiceRoller.new(test.length, 6, test).points).to be_an(Integer)
      end
      it "for sample 3" do
        test = [4,2,3]
        expect(GreedyDiceRoller.new(test.length, 6, test).points).to be_an(Integer)
      end
      it "for sample 4" do
        test = [5,5,5,5,5]
        expect(GreedyDiceRoller.new(test.length, 6, test).points).to be_an(Integer)
      end
      it "for sample 5" do
        test = [6,1,1,1,1,1]
        expect(GreedyDiceRoller.new(test.length, 6, test).points).to be_an(Integer)
      end

      context "accurately calculates points based on the number of 1s rolled" do
        it "for sample 6" do
          test = [1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(100)
        end
        it "for sample 7" do
          test = [4,2,3,1,3,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(100)
        end
        it "for sample 8" do
          test = [1,2,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(200)
        end
        it "for sample 9" do
          test = [1,2,1,2,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1000)
        end
        it "for sample 10" do
          test = [1,1,1,2,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(2000)
        end
        it "for sample 11" do
          test = [1,1,1,2,1,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(4000)
        end
        it "for sample 12" do
          test = [1,1,1,1,1,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(8000)
        end
      end
      context "accurately calculates points based on the number of 5s rolled" do
        it "for sample 13" do
          test = [5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(50)
        end
        it "for sample 14" do
          test = [4,2,3,5,3,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(50)
        end
        it "for sample 15" do
          test = [5,2,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(100)
        end
        it "for sample 16" do
          test = [5,2,5,2,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(500)
        end
        it "for sample 17" do
          test = [5,5,5,2,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1000)
        end
        it "for sample 18" do
          test = [5,5,5,2,5,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(2000)
        end
        it "for sample 19" do
          test = [5,5,5,5,5,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(4000)
        end
      end

      context "accurately calculates points for more than three of any number other than 1" do
        it "for sample 20" do
          test = [2,2,2]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(200)
        end
        it "for sample 21" do
          test = [3,2,3,4,3,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(300)
        end
        it "for sample 22" do
          test = [4,4,4,2]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(400)
        end
        it "for sample 23" do
          test = [2,2,2,2,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(450)
        end
        it "for sample 24" do
          test = [3,3,3,3,3]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1200)
        end
        it "for sample 25" do
          test = [4,4,4,2,4,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1600)
        end
        it "for sample 26" do
          test = [3,3,3,3,3,3]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(2400)
        end
        it "for sample 27" do
          test = [4,4,4,4,4,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(3200)
        end
        it "for sample 28" do
          test = [6,6,6,6,6,6]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(4800)
        end
      end

      context "accurately calculates points for any combination of 5s and 1s rolled" do
        it "for sample 28" do
          test = [5,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(150)
        end
        it "for sample 29" do
          test = [4,1,3,5,3,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(150)
        end
        it "for sample 30" do
          test = [5,1,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(250)
        end
        it "for sample 31" do
          test = [5,1,5,1,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(700)
        end
        it "for sample 32" do
          test = [5,1,5,5,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1100)
        end
        it "for sample 33" do
          test = [1,1,1,5,6]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1050)
        end
        it "for sample 34" do
          test = [5,5,5,5,1,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(2100)
        end
      end

      context "accurately calculates points for combinations of multiples, 5s and 1s" do
        it "for sample 34" do
          test = [5,1,3,3,3]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(450)
        end
        it "for sample 34" do
          test = [4,1,4,5,3,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(550)
        end
        it "for sample 35" do
          test = [5,1,1,2,2,2]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(450)
        end
        it "for sample 36" do
          test = [5,1,5,1,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(700)
        end
        it "for sample 37" do
          test = [5,1,5,5,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1100)
        end
        it "for sample 38" do
          test = [1,1,1,5,6]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1050)
        end
        it "for sample 40" do
          test = [5,5,5,5,1,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(2100)
        end
      end

      context "accurately calculates points for three pairs" do
        it "for sample 41" do
          test = [2,2,3,3,4,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(500)
        end
        it "for sample 42" do
          test = [1,1,3,3,4,4]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(500)
        end
      end

      context "accurately calculates points for a 5 dice straight" do
        it "for sample 43" do
          test = [1,2,3,4,5]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1000)
        end
        it "for sample 44" do
          test = [2,3,4,5,6]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1000)
        end
        it "for sample 45" do
          test = [1,2,3,4,5,3]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1000)
        end
        it "for sample 46" do
          test = [3,2,3,4,5,6]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1000)
        end
        it "for sample 47" do
          test = [5,2,3,4,5,6]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1050)
        end
        it "for sample 48" do
          test = [1,2,3,4,5,1]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1100)
        end
      end

      context "accurately calculates points for a 6 dice straight" do
        it "for sample 49" do
          test = [1,2,3,4,5,6]
          expect(GreedyDiceRoller.new(test.length, 6, test).points).to eq(1500)
        end
      end
    end
  end
end
