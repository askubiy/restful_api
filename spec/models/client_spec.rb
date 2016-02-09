require 'spec_helper'

describe Client do
  before { @client = FactoryGirl.create(:client) }

  subject { @client }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should be_valid }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_uniqueness_of(:auth_token)}

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @client.generate_authentication_token!
      expect(@client.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_client = FactoryGirl.create(:client, auth_token: "auniquetoken123")
      @client.generate_authentication_token!
      expect(@client.auth_token).not_to eql existing_client.auth_token
    end
  end

end
