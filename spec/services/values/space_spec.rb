require 'rails_helper'

describe Space do
  let(:attrs) {{ coordinates: "A2" }}
  subject { Space.new(attrs)}

  it 'exists' do
    expect(subject).to be_a Space
  end

  context 'instance methods' do
    context '#attack!' do
      it 'returns a string as Hit or Miss'  do
        expect(subject.attack!).to be_a(String)
        expect(subject.attack!).to eq('Miss')
      end
    end
  end
end
