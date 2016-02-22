require 'spec_helper'

describe Api::V1::HotelsController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @hotels_count = 15
      @hotels_count.times { FactoryGirl.create :hotel }
      get :index
    end

    it "returns list of all hotels" do
      hotels_response = json_response
      expect(hotels_response[:hotels].length).to eql @hotels_count
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      @hotel = FactoryGirl.create :hotel
      get :show, id: @hotel.id
    end

    it "returns the information about a hotel on a hash" do
      hotels_response = json_response
      expect(hotels_response[:hotel][:name]).to eql @hotel.name
    end

    it { should respond_with 200 }

    it "returns 404 Error" do
      get :show, id: 99999
      should respond_with 404
    end

  end
end
