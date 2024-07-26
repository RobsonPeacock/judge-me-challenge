FactoryBot.define do
  sequence(:predefined_number) do |n|
    numbers = (1..5).to_a.cycle.take(30)
    numbers[n % 30]
  end

  factory :review do
    body { 'Great product!' }
    rating { generate(:predefined_number) }
    tags { nil }
    reviewer_name { 'Robson Peacock' }
    product

    trait :last_month do
      created_at { 1.month.ago }
    end

    trait :two_months_ago do
      created_at { 2.months.ago }
    end

    trait :three_months_ago do
      created_at { 3.months.ago }
    end
  end
end