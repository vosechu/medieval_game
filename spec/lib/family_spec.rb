require 'family'

describe Family do
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
