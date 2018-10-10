require "rails_helper"

describe User do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'attributes' do
    it 'should have default status as non-active' do
      user = User.create(name: 'Elena', email: 'elena@example.com', password: 'test')

      expect(user.status).to eq('non-active')
    end
  end
end
