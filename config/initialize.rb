require 'yaml'
require 'bundler/setup'
APP_PATH = File.expand_path('../../', __FILE__) + '/'

CREDENTIALS = YAML.load_file(APP_PATH + 'config/credentials.yml')

require APP_PATH + 'lib/google.rb'
require APP_PATH + 'lib/harvest.rb'
require APP_PATH + 'lib/qbo.rb'