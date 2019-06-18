class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    # sequence_length = @sequence_length + 1      # increment sequence length
    unless game_over                              # if game_over == false, do code below. do code below unless game_over == true
      show_sequence
      require_sequence
      # sequence_length = @sequence_length + 1    # why doesn't this work?
      # @sequence_length = @sequence_length + 1   # this works too
      self.sequence_length = sequence_length + 1  # this is better
      round_success_message
    end
  end

  def show_sequence
    add_random_color
  end

  def require_sequence

  end

  def add_random_color
    seq << COLORS.sample      # adds 1 random color string from COLORS array to seq array
  end

  def round_success_message

  end

  def game_over_message

  end

  def reset_game
    # @sequence_length = 1      # works but bad practice 
    self.sequence_length = 1
    self.game_over = false      # this works!
    self.seq = []               
    # seq = []                  # this doesn't work!
  end
end
