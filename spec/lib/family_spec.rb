require 'spec_helper'
require 'family'
require 'actor_collection_examples'

describe Family do
  it_behaves_like 'actor_collection'

  subject {
    described_class.new(
      head: instance_double("Citizen"),
      next_in_line: instance_double("Citizen"),
      children: [instance_double("Citizen", :child? => true)]
    )
  }

  it 'does something' do
    subject
  end
end
