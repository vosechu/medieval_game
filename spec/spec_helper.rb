$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'

RSpec.configure do |rspec|
  rspec.after :each do
    # If this fails, you need to reset the date after one of your specs
    # Use this after block:
    # after :each do
    #   Calendar.date = Date.new(800, 1, 1, Date::GREGORIAN)
    # end
    require 'calendar'
    expect(Calendar.date).to eq(DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN))
  end
end
