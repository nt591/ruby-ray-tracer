require_relative './tuple.rb'

class Engine
  attr_accessor :environment, :projectile

  def initialize(environment, projectile)
    @environment = environment
    @projectile = projectile
  end

  def run_loop
    proj = projectile
    while proj.y > 0
      puts "---- READING Y AND X"
      puts proj.position.y
      puts proj.position.x
      proj = tick(environment, proj)
    end

    puts "finished"
  end

  def self.test
    env = Environment.new(
      Vector.new(0, -0.1, 0),
      Vector.new(0, 0, -0.01)
    )
    proj = Projectile.new(
      Point.new(0, 1, 0),
      Vector.new(1, 1, 0).normalize
    )

    engine = Engine.new(env, proj)
    puts engine
    engine.run_loop
  end

  private

  def tick(environment, projectile)
    pos = projectile.position + projectile.velocity
    vel = projectile.velocity + environment.gravity + environment.wind
    Projectile.new(pos, vel)
  end
end

class Projectile
  attr_accessor :position, :velocity

  def initialize(position, velocity)
    if !position.is_a?(Point)
      raise InvalidClassInitializerError.new "Position must be a point"
    end
    if !velocity.is_a?(Vector)
      raise InvalidClassInitializerError.new "Velocity must be a vector"
    end
    @position = position
    @velocity = velocity
  end

  def y
    position.y
  end
end

class Environment
  attr_accessor :gravity, :wind

  def initialize(gravity, wind)
    if !gravity.is_a?(Vector)
      raise InvalidClassInitializerError.new "Gravity must be a vector"
    end
    if !wind.is_a?(Vector)
      raise InvalidClassInitializerError.new "Wind must be a vector"
    end
    @gravity = gravity
    @wind = wind
  end
end

class InvalidClassInitializerError < StandardError; end

Engine.test