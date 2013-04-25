begin
  require 'configoro'
rescue LoadError, Gem::LoadError
  # not necessary; make conditionally a noop
  def conditionally(*) end
else
  rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__)
  ::Configoro.paths << File.join(rails_root, 'config', 'environments')

  def conditionally(configuration_path, value, &block)
    groups = []
    dev    = Configoro.load_environment('development')
    test   = Configoro.load_environment('test')
    prod   = Configoro.load_environment('production')

    groups << :development if eval("dev.#{configuration_path}") == value
    groups << :test if eval("test.#{configuration_path}") == value
    groups << :production if eval("prod.#{configuration_path}") == value

    groups.each { |g| group g, &block }
  end
end
