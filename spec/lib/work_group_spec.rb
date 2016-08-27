require 'spec_helper'
require 'work_group'

describe WorkGroup do
  subject {
    described_class.new(
      name: "test",
      needs: { "test" => { "adults" => 2 } }
    )
  }

  it 'does something' do
    subject.finished?
  end
end
