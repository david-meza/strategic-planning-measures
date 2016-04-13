#Storing it all in one file until the app grows and we need to make a file for each model
FactoryGirl.define do

  factory :user, aliases: [:author, :editor] do
    sequence(:email)  { |n| "test#{n}@raleighnc.gov" }
    password                "testpassword"
    password_confirmation   "testpassword"
    confirmed_at            Date.today
    
    factory :admin do
      admin                 true
    end
  end

  factory :key_focus_area do
    sequence(:name) { |n| "Key Focus Area #{n}" }
    goal                  "To conquer the world"
    association :author, factory: :admin
  end

  factory :objective do
    association :key_focus_area
    sequence(:name)     { |n| "Objective #{n}" }
    description         Faker::Lorem.sentence
    association :author, factory: :admin
  end

  factory :performance_measure, aliases: [:measure] do
    description         Faker::Lorem.sentence
    unit_of_measure     "Percentage"
    association :measurable, factory: :objective
    association :author, factory: :admin
    
    factory :measure_no_objective do
      association :measurable, factory: :key_focus_area
    end
  end

  factory :measure_report, aliases: [:report] do
    association :author
    association :performance_measure, factory: :measure
    date_start      1.year.ago.to_date
    date_end        Date.today
    status          "Almost there!"
  end

  factory :performance_factor, aliases: [:factor] do
    association :performance_measure
    label_text  "Raleigh Population"
    field_type  "number"
  end

  factory :performance_factor_entry, aliases: [:factor_entry] do
    association :performance_factor
    association :measure_report
    data        "500,000"
    comments    "A lot! (not really)"
  end

end