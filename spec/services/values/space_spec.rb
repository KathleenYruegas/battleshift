require 'rails_helper'

describe Space do
  let(:attrs) {{ coordinates: "A2" }}
  subject { Space.new(attrs)}

  it 'exists' do
    expect(subject).to be_a Space
  end

  context 'instance methods' do
    context '#attack!' do
      it 'returns a string as Hit or Miss' do
        expect(subject.attack!).to be_a(String)
        expect(subject.attack!).to eq('Miss')
      end
    end
    context '#occupy!(ship)' do
      it 'changes contents from nil to ship object' do
        ship = Ship.new(2)
        expect(subject.occupy!(ship)).to be_a(Ship)
      end
    end
    context '#occupied?' do
      it 'returns true or false' do
        expect(subject.occupied?).to be(true).or be(false)
      end
    end
  end
end
