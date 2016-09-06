require 'spec_helper'
require 'citizen'
require 'actor_examples'
require 'owner_examples'

describe Citizen do
  it_behaves_like 'actor'
  it_behaves_like 'owner'

  subject { described_class.new }

  it 'does something' do
    subject
  end
end
