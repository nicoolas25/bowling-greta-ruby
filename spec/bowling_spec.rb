require "bowling"

RSpec.describe Bowling do
  let(:game) { Bowling.new }

  describe "playing nothing" do
    it "scores 0" do
      expect(play([])).to eq 0
    end
  end

  describe "a perfect game" do
    it "scores 300" do
      expect(play([10] * 12)).to eq 300
    end
  end

  describe "finishing the last frame with 3 strikes" do
    it "scores 30, counting only the extra strikes as bonuses" do
      expect(play(([0, 0] * 9) + [10, 10, 10])).to eq 30
    end
  end

  describe "finishing with a spare + 5" do
    it "scores 15, counting only the extra roll as a bonus" do
      expect(play(([0, 0] * 9) + [5, 5, 5])).to eq 15
    end
  end

  describe "doing 20 times 4" do
    it "scores 80" do
      expect(play([4] * 20)).to eq 80
    end
  end

  describe "playing a strike without rolling anything else" do
    it "scores 10 even though the strike's bonus is not known" do
      expect(play([10])).to eq 10
    end
  end

  describe "playing a strike with rolling only once after" do
    it "applies the strike's bonus even partially" do
      expect(play([10, 5])).to eq 20
    end
  end

  describe "playing a spare without rolling anything else" do
    it "scores 10 even though the spare's bonus is not known" do
      expect(play([5, 5])).to eq 10
    end
  end

  def play(rolls)
    rolls.each { |roll| game.roll(roll) }
    game.score
  end
end
