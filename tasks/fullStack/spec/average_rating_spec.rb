require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @shop = FactoryBot.create(:shop)
    product = FactoryBot.create(:product, shop_id: @shop.id)
    FactoryBot.create_list(:review, 10, :last_month, product_id: product.id)
    FactoryBot.create_list(:review, 10, :two_months_ago, product_id: product.id)
    FactoryBot.create_list(:review, 10, :three_months_ago, product_id: product.id)
  end

  it "returns the difference of the average ratings from the last 3 months" do
    expect(@shop.average_rating).to eq([0.0, 0.0])
  end
end