require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'GET #index' do
    before do
      shop = FactoryBot.create(:shop)
      product = FactoryBot.create(:product, shop_id: shop.id)
      FactoryBot.create_list(:review, 5, product_id: product.id)

      get :index, params: { shop_id: shop.id }
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'returns products' do
      data = assigns(:data)
      expect(data.product[0].count).to eq(1)
    end

    it 'returns reviews' do
      data = assigns(:data)
      expect(data.first[:product].reviews.count).to eq(5)
    end
  end

  describe 'GET #new' do
    before do
      product = FactoryBot.create(:product)
      get :new, params: { product_id: product.id }
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end