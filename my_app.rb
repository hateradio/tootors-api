require './lib/swaggering'
require './model/db'
require './model/tootor'

# only need to extend if you want special configuration!
class MyApp < Swaggering
  self.configure do |config|
    config.api_version = '1.0.0'
    mime_type :json, 'application/json'
  end
end

# include the api files
Dir["./api/*.rb"].each { |file|
  require file
}
