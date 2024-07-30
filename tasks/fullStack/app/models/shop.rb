class Shop < ApplicationRecord
  has_many :products
  has_many :reviews, through: :products

  def average_rating
    reviews = Review.joins(product: :shop).where(shops: { id: self.id }).pluck(:rating, :created_at)

    reviews_by_month = reviews.group_by { |rating, created_at| created_at.beginning_of_month }
    transformed_reviews = reviews_by_month.transform_values { |value| value.map{ |rating, created_at| rating } }
    month_averages = transformed_reviews.map { |date, ratings| ratings.sum.to_f / ratings.size }
    month_averages.each_cons(2).map { |cur_el, next_el| (cur_el - next_el).round(2) }
  end
end
