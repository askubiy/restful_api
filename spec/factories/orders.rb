FactoryGirl.define do
  factory :order do
    customer_name "MyString"
    phone "MyString"
    start_date "2016-02-17"
    end_date "2016-02-17"
    price "9.99"
    client nil
  end
end
