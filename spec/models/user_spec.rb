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
    it 'should have an activation token attribute' do
      user = create(:user)

      expect(user.activation_token)
    end
  end

  describe 'instance method' do
    context '#account_activation' do
      it 'should change their status to active' do
        user = User.create(name: 'Elena', email: 'elena@example.com', password: 'test')
        user.account_activation

        expect(user.status).to eq('active')
      end
    end
  end
end
