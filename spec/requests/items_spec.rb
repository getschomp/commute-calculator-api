require 'rails_helper'

RSpec.describe "Items", type: :request do
  # Items will not be in the final project.
  # This just tests that everything is behind a wall for now.
  # As the application progresses only certain things will be behind the wall
  # and similar logic will be moved elsewhere
  # TODO: Move the authentication logic to a helper

  context 'authenticated' do

    let(:auth_details) { { email: 'example@mail.com', password: '123123123' } }
    let(:token) {
      Services::Authenticator.new(
        auth_details[:email], auth_details[:password]
      ).call
    }

    before :each do
      User.create!(
        auth_details.merge(password_confirmation: auth_details[:password]))
    end

    describe "GET /items" do
      it "returns a 200 sucess" do
        get(items_path, nil, Authorization: token)
        expect(response).to have_http_status(200)
      end
    end

  end

  context 'unauthenticated' do

    describe "GET /items" do
      it "returns a 401 error " do
        get(items_path)
        expect(response).to have_http_status(401)
      end
    end
  end
end
