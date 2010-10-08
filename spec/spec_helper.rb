require 'rspec'

# Add lib to the load path
$: << File.join(File.dirname(__FILE__), '..', 'lib')

RSpec.configure do |config|
  config.mock_with :rspec
  config.before(:each) do
    ToOutput.reset_config
  end
end
