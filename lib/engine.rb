require_relative './tuple.rb'
require_relative './canvas.rb'

class Engine
  attr_accessor :projectile
  attr_reader :environment, :canvas

  def initialize(environment, projectile)
    @environment = environment
    @projectile = projectile
    @canvas = Canvas.new(900, 550)
  end

  def run_loop
    while projectile_in_air?
      canvas.write_at(projectile_x, projectile_y, Color.red)
      tick
    end

    save!
  end

  def self.test
    env = Environment.new(
      Vector.new(0, -0.1, 0),
      Vector.new(-0.010, 0, 0)
    )
    proj = Projectile.new(
      Point.new(0, 1, 0),
      Vector.new(1, 1.8, 0).normalize * 11.25
    )

    engine = Engine.new(env, proj)
    engine.run_loop
  end

  private

  def save!
    open('canvas.ppm', 'w') do |f|
      f << canvas.to_PPM.render
    end
  end

  def tick
    pos = projectile.position + projectile.velocity
    vel = projectile.velocity + environment.gravity + environment.wind
    @projectile = Projectile.new(pos, vel)
  end

  def projectile_x
    projectile.x.round
  end

  def projectile_y
    canvas.height - projectile.y.round
  end

  def projectile_in_air?
    projectile.y > 0
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

  def x
    position.x
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