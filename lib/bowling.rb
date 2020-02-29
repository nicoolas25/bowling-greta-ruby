class Bowling
  PINS = 10
  FRAMES = 10
  FRAME_SIZE = 2
  SPARE_BONUS_ROLLS = 1
  STRIKE_BONUS_ROLLS = 2

  def initialize
    @rolls = []
  end

  def roll(roll)
    @rolls << roll
  end

  def score
    frames.sum(&:score)
  end

  private

  def frames
    frames = (1..FRAMES).map { |frame_number| BowlingFrame.new(frame_number) }
    frames.reduce(@rolls) { |rolls, frame| frame.setup!(rolls).next_rolls }
    frames
  end

  class BowlingFrame
    attr_reader :next_rolls

    def initialize(frame_number)
      @frame_number = frame_number
    end

    def setup!(rolls)
      raise "Can't setup a BowlingFrame more than once" if defined?(@rolls)

      @rolls = []
      @next_rolls = rolls.dup
      @rolls << @next_rolls.shift until @next_rolls.empty? || frame_finished?
      self
    end

    def score
      @rolls.sum + @next_rolls.first(bonus_rolls).sum
    end

    private

    def frame_finished?
      return false if last_frame?

      spare? || strike? || maximum_roll_per_frame_reached?
    end

    def last_frame?
      @frame_number == FRAMES
    end

    def strike?
      @rolls.first == PINS
    end

    def spare?
      !strike? && @rolls.sum >= PINS
    end

    def maximum_roll_per_frame_reached?
      @rolls.size >= FRAME_SIZE
    end

    def bonus_rolls
      if spare?
        SPARE_BONUS_ROLLS
      elsif strike?
        STRIKE_BONUS_ROLLS
      else
        0
      end
    end
  end
end
