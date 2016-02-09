require 'spec_helper'

describe Hotel, type: :model do
  let(:hotel) { FactoryGirl.build :hotel }
  subject { hotel }

  it { should respond_to(:name) }
  it { should respond_to(:period_booking) }

  it { should be_valid }
end
