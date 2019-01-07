FactoryBot.define do
  factory :ticket do
    start_id { 1 }
    end_id { 1 }
    train_no { 'MyString' }
    start_time { 'MyString' }
    end_time { 'MyString' }
    duration { 'MyString' }
  end
end
