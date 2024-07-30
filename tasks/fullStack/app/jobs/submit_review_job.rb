class SubmitReviewJob
  include Sidekiq::Job
  sidekiq_options retry: 3

  def perform(params)
    params = JSON.parse(params)
    Review.create!(params)
  end
end
