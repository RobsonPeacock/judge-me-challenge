class ReviewsController < ApplicationController
  before_action :set_product, only: [:new]

  DEFAULT_TAGS = ['default']

  def index
    params[:shop_id] ||= 1
    @shop = Shop.find(params[:shop_id])

    if @shop.present?
      params[:per_page] ||= 10
      offset = params[:page].to_i * params[:per_page]

      @shops = Shop.where.not(id: params[:shop_id]).limit(5)

      @data = []
      products = Product.where("shop_id = #{params[:shop_id]}").limit(5).sort_by(&:created_at)[offset..(offset + params[:per_page])]
      products.each do |product|
        reviews = product.reviews.limit(5).sort_by(&:created_at)[offset..(offset + params[:per_page])]
        @data << { product: product, reviews: reviews }
      end
    end
  end

  def new
    @review = Review.new
  end

  def create
    # TODO: Create reviews in background. No need to show errors (if any) to users, it's fine to skip creating the review silently when some validations fail.

    tags = tags_with_default(review_params)
    SubmitReviewJob.perform_async(review_params.to_json)

    flash[:notice] = 'Review is being created in background. It might take a moment to show up'
    redirect_to action: :index, shop_id: Product.find_by(id: review_params[:product_id]).shop_id
  end

  def average
    params[:shop_id] ||= 1
    @shop = Shop.find(params[:shop_id])
    @ratings = @shop.average_rating
  end

  private

  # Prepend `params[:tags]` with tags of the shop (if present) or DEFAULT_TAGS
  # For simplicity, let's skip the frontend for `tags`, and just assume frontend can somehow magically send to backend `params[:tags]` as a comma-separated string
  # The logic/requirement of tags is that:
  #  - A review can have `tags` (for simplicity, tags are just an array of strings)
  #  - If the shop has some `tags`, those tags of the shop should be part of the review's `tags`
  #  - Else (if the shop doesn't have any `tags`), the default tags (in constant `DEFAULT_TAGS`) should be part of the review's `tags`
  # One may wonder what an odd logic and lenthy comment, thus may suspect something hidden here, an easter egg perhaps.
  def tags_with_default(params)
    product = Product.find_by(id: review_params[:product_id])
    tags = product.shop.tags || DEFAULT_TAGS
    params[:tags] ||= []
    params[:tags] += tags
  end

  def review_params
    params.require(:review).permit(:product_id, :body, :rating, :reviewer_name)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
