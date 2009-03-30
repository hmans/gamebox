# Levels represent on level of game play.  Some games will likely have only one
# level. Level is responsible for loading its background, props, and directors.
# PhysicalLevel adds a physics space to the Level
require 'level'
require 'physics'
class PhysicalLevel < Level
  #  GRAVITY = 0.01
#  DAMPING = 0.8
  DAMPING = 0.994
  STEP = 10
  attr_accessor :space

  def initialize(actor_factory,resource_manager,sound_manager,opts={})
    @actor_factory = actor_factory
    @resource_manager = resource_manager
    @sound_manager = sound_manager
    @opts = opts
    @directors = []
    @space = Space.new
    @space.iterations = 7
    @space.damping = DAMPING
    # TODO make gravity configurable/optional
    #    @space.gravity = vec2(0,GRAVITY)
    setup
  end

  def update_physics(time)
    num_steps = time/STEP
    num_steps.times do 
      @space.step STEP
    end
  end

  def update(time)
    update_physics time
    for dir in @directors
      dir.update time
    end
  end

  def register_physical_object(obj,static=false)
    @space.add_body(obj.body)
    if static
      @space.add_static_shape(obj.shape)
    else
      @space.add_shape(obj.shape)
    end
  end

  def unregister_physical_object(obj,static=false)
    @space.remove_body(obj.body)
    if static
      @space.remove_static_shape(obj.shape)
    else
      @space.remove_shape(obj.shape)
    end
  end

end
