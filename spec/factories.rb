#Storing it all in one file until the app grows and we need to make a file for each model
FactoryGirl.define do
  # A block defining the attributes of a model
  # The symbol is how you will later call it
  # Factory Girl assumes that your class name
  # is the same as the symbol you passed
  # (so here, it assumes this is a User)
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

end