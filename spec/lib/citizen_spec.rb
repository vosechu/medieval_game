require 'spec_helper'
require 'citizen'
require 'actor_examples'

describe Citizen do
  it_behaves_like 'actor'

  subject { described_class.new }

  it 'does something' do
    subject
  end
end
