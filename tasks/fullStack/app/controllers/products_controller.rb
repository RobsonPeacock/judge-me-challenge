class ProductsController < ApplicationController
  def index
    @products = Product.limit(5)
  end
end
