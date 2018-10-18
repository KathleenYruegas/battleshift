require 'rails_helper'

describe Ship do
  length = 2
  subject { Ship.new(length) }

  it 'exists' do
    expect(subject).to be_a Ship
  end

  context 'instance methods' do
    context '#hit!' do
      it 'increases @damage counter' do
        expect(subject.hit!).to eq(1)
      end
    end

    context '#is_sunk?' do
      it 'compares if damage and length are equal /true or false' do
        expect(subject.is_sunk?).to be(true).or be(false)
      end
    end
  end
end
