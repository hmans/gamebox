class Game

  constructor :wrapped_screen, :input_manager, :sound_manager,
    :mode_manager

  def setup
    @mode_manager.change_mode_to :default
    @input_manager.framerate = 20
  end

  def update(time)
    @mode_manager.update time
    draw
  end

  def draw
    @mode_manager.draw @wrapped_screen
    @wrapped_screen.flip
  end

end