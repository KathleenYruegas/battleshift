require 'rails_helper'

describe Board do
  length = 4
  subject { Board.new(length) }

  it 'exists' do
    expect(subject).to be_a Board
  end

  context 'instance methods' do
    context '#get_row_letters' do
      it 'returns an array of X letters(string)' do
        expect(subject.get_row_letters).to be_an Array
        expect(subject.get_row_letters.count).to eq 4
      end
    end

    context '#get_column_numbers' do
      it 'returns an array of X numbers(string)' do
        expect(subject.get_column_numbers).to be_an Array
        expect(subject.get_column_numbers.count).to eq 4
      end
    end

    context '#space_names' do
      it 'returns an array of X coordinates(string)' do
        expect(subject.space_names).to be_an Array
        expect(subject.space_names.count).to eq 16
      end
    end

    context '#create_spaces' do
      it 'returns an a hash of X coordinates as keys and  values are a Space object)' do
        expect(subject.create_spaces).to be_a Hash
        expect(subject.create_spaces.keys.count).to eq 16
      end
    end
  end
end
