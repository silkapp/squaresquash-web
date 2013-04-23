if Squash::Configuration.concurrency.background_runner == 'Resque'
  rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
  rails_env  = ENV['RAILS_ENV'] || 'development'

  common_file = File.join(rails_root.to_s, 'config', 'environments', 'common', 'concurrency.yml')
  env_file    = File.join(rails_root.to_s, 'config', 'environments', rails_env, 'concurrency.yml')

  config = YAML.load_file(common_file)
  if File.exist?(env_file)
    config.merge! YAML.load_file(env_file)
  end

  Resque.redis = config['resque'][rails_env]
end
