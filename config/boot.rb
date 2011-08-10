require 'bundler'

if ENV['RUBY_ENV'] == 'test'
  Bundler.require(:default, :test)
else
  Bundler.require(:default)
end

module BootLoader
  ::APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  def self.load_files(files)
    files.each do |file|
      require file
    end
  end

  def self.glob_for(relative_path)
    Dir.glob(File.join(APP_ROOT, relative_path, '**/*.rb'))
  end

  def self.glob_and_load(relative_path)
    load_files(glob_for(relative_path))
  end
end

# Load configs
BootLoader.load_files([File.join(APP_ROOT, 'config', 'app_config')])

# Load models
BootLoader.glob_and_load('models')
