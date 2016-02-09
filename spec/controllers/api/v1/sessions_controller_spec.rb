require 'spec_helper'

describe Api::V1::SessionsController do

  describe "POST #create" do

   before(:each) do
    @client = FactoryGirl.create :client
   end

    context "when the credentials are correct" do

      before(:each) do
        credentials = { email: @client.email, password: "12345678" }
        post :create, { session: credentials }
      end

      it "returns the client record corresponding to the given credentials" do
        @client.reload
        expect(json_response[:auth_token]).to eql @client.auth_token
      end

      it { should respond_with 200 }
    end

    context "when the credentials are incorrect" do

      before(:each) do
        credentials = { email: @client.email, password: "invalidpassword" }
        post :create, { session: credentials }
      end

      it "returns a json with an error" do
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      @client = FactoryGirl.create :client
      sign_in @client
      delete :destroy, id: @client.auth_token
    end

    it { should respond_with 204 }

  end
end