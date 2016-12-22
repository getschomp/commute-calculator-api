require 'rails_helper'

RSpec.describe "json_web_token" do
  let(:payload) { {'jon_snow' => 'winterfell'} }

  it "creates a token" do
    token = JsonWebToken.encode(payload, 1.hour.from_now)
    payload_size = payload.keys.first.size + payload.values.first.size
    expect(token.size).to be > (payload_size)
  end

  it "decodes the token" do
    token = JsonWebToken.encode(payload, 1.hour.from_now)
    expect{ JsonWebToken.decode(token) }.to_not raise_error
  end

  it "expires the token" do
    token = JsonWebToken.encode(payload, 1.second.from_now)
    sleep(2.seconds)
    expect{ JsonWebToken.decode(token) }.to raise_error(
      JWT::ExpiredSignature
    )
  end
end
