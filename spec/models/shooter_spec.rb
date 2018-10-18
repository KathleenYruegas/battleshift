require 'rails_helper'

describe Shooter do
  let(:attrs) {{ board: Board.new(4),
                target: 'A4' }}
  subject { Shooter.new(attrs)}

  it 'exists' do
    expect(subject).to be_a Shooter
  end

  context 'instance methods' do
    context '#fire!' do
      it 'returns a string as Hit or Miss' do
        expect(subject.fire!).to be_a(String)
      end
    end
  end

end
