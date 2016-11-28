$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'rspec'
require 'contracts'
require 'celluloid/current'

RSpec.configure do |rspec|
  rspec.before(:each) do |example|
    # Hide Celluloid Logger output
    Celluloid.logger = nil
  end

  rspec.after :each do
    # If this fails, you need to reset the date after one of your specs
    # Use this after block:
    # after :each do
    #   Calendar.date = DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN)
    # end
    require 'calendar'
    expect(Calendar.date).to eq(DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN))
  end

  # Make contracts accept all RSpec doubles
  Contract.override_validator(:class) do |contract|
    lambda do |arg|
      arg.is_a?(RSpec::Mocks::Double) ||
        arg.is_a?(RSpec::Mocks::InstanceVerifyingDouble) ||
        arg.is_a?(contract)
    end
  end
end
