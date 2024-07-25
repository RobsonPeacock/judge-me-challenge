FactoryBot.define do
  factory :review do
    body { 'Great product!' }
    rating { 4.0 }
    tags { nil }
    reviewer_name { 'Robson Peacock' }
    product
  end
end