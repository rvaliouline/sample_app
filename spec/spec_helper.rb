require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  unless defined?(Rails)
    require File.dirname(__FILE__) + "/../config/environment"
  end
  require 'rspec/rails'
  #requires supporting files with custom matchers and macros, etc, in ./support/ and its subdirs
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
  
  Rspec.configure do |config|
    # == mock framework
    #if you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #config.mock_with :mocha      
    #config.mock_with :flexmock
    #config.mock_with :rr
    config.mock_with :rspec
    
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    
    #if youre not using activerecord or you'd prefer not to run each of your
    #examples within a transaction, comment the following line or assign false
    #instad of true
    config.use_transactional_fixtures = true
    
    ### Part of a Spork hack. see http://bit.ly/arY19y
    #Emulate initiatlizer set_clear_dependencies_hook in
    #railties/lib/rails/application/bootstrap.rb
    ActiveSupport::Dependencies.clear
  end
end
