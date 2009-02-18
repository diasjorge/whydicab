# Go to http://wiki.merbivore.com/pages/init-rb

require 'config/dependencies.rb'

use_orm :datamapper
use_test :rspec
use_template_engine :erb

Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper

  # cookie session store configuration
  c[:session_secret_key]  = '265dd90a56f72105995bf9a04c7854ca8c826bb9'  # required for cookie session store
  # c[:session_id_key] = '_session_id' # cookie session id key, defaults to "_session_id"
end

Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
  require 'ostruct'
  begin
    Settings = OpenStruct.new(YAML::load(File.open("config/settings.yml")))
  rescue
    Merb.logger.warn("Loading default settings, rename and edit 'config/settings.yml.example'")
    Settings = OpenStruct.new(YAML::load(File.open("config/settings.yml.example")))
  end
end

Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
  Merb.add_mime_type(:rss, nil, %w[application/rss+xml], :charset => "utf-8")
  Merb.add_mime_type(:atom, nil, %w[application/atom+xml], :charset => "utf-8")
end

require 'lib/whydicab'
