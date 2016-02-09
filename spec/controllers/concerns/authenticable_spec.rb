require 'spec_helper'

class Authentication
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_client" do
    before do
      @client = FactoryGirl.create :client
      request.headers["Authorization"] = @client.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end
    it "returns the client from the authorization header" do
      expect(authentication.current_client.auth_token).to eql @client.auth_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @client = FactoryGirl.create :client
      allow(authentication).to receive(:current_client).and_return(nil)
      allow(response).to receive(:response_code).and_return(401)
      allow(response).to receive(:body).and_return({"errors" => "Not authenticated"}.to_json)
      allow(authentication).to receive(:response).and_return(response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it {  should respond_with 401 }
  end

  describe "#client_signed_in?" do
    context "when there is a client on 'session'" do
      before do
        @client = FactoryGirl.create :client
        allow(authentication).to receive(:current_client).and_return(@client)
      end

      it { should be_client_signed_in }
    end

    context "when there is no client on 'session'" do
      before do
        @client = FactoryGirl.create :client
        allow(authentication).to receive(:current_client).and_return(nil)
      end

      it { should_not be_client_signed_in }
    end
  end
end