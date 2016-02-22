require 'spec_helper'

describe Api::V1::ClientsController do

  describe "GET #show" do
    before(:each) do
      @client = FactoryGirl.create :client
      get :show, id: @client.id
    end

    it "returns the information about a reporter on a hash" do
      client_response = json_response
      expect(client_response[:email]).to eql @client.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @client_attributes = FactoryGirl.attributes_for :client
        post :create, { client: @client_attributes }
      end

      it "renders the json representation for the client record just created" do
        client_response = json_response
        expect(client_response[:email]).to eql @client_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_client_attributes = { password: "12345678",
                                       password_confirmation: "12345678" }
        post :create, { client: @invalid_client_attributes }
      end

      it "renders an errors json" do
        client_response = json_response
        expect(client_response).to have_key(:errors)
      end

      it "renders the json errors on why the client could not be created" do
        client_response = json_response
        expect(client_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @client = FactoryGirl.create :client
      api_authorization_header @client.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: @client.id,
                         client: { email: "newmail@example.com" } }
      end

      it "renders the json representation for the updated client" do
        client_response = json_response
        expect(client_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        patch :update, { id: @client.id,
                         client: { email: "bademail.com" } }
      end

      it "renders an errors json" do
        client_response = json_response
        expect(client_response).to have_key(:errors)
      end

      it "renders the json errors on whye the client could not be created" do
        client_response = json_response
        expect(client_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

end
