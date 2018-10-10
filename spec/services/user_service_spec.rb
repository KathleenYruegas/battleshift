require "rails_helper"

describe UserService do
  it 'exists' do

    user_service = UserService.new({id: 1})

    expect(user_service).to be_a(UserService)
  end

  context 'instance method' do
    describe '#single_user_data' do
      it 'should return a hash' do
        VCR.use_cassette("single_user_data") do
          user_service = UserService.new({id: 1})

          expect(user_service.single_user_data).to be_a(Hash)
          expect(user_service.single_user_data).to have_key(:id)
          expect(user_service.single_user_data).to have_key(:name)
          expect(user_service.single_user_data).to have_key(:email)
        end
      end
    end
    describe '#all_user_data' do
      it 'returns the parsed response' do
        VCR.use_cassette("all_user_data") do
          user_service = UserService.new

          expect(user_service.all_user_data).to be_a(Array)
          expect(user_service.all_user_data.first).to have_key(:id)
          expect(user_service.all_user_data.first).to have_key(:name)
          expect(user_service.all_user_data.first).to have_key(:email)
        end
      end
    end
    describe '#update_user_data' do
      it 'returns the parsed response with updated information' do
        VCR.use_cassette("updated_user_data") do
          user_service = UserService.new({id: 1})
          user_hash = JSON.parse(user_service.update_user_data("email@example.com").body)

          expect(user_hash).to be_a(Hash)
          expect(user_hash).to have_key("id")
          expect(user_hash).to have_key("name")
          expect(user_hash).to have_key("email")
        end
      end
    end
  end
end
