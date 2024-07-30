require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "creation" do
    before do
      @review = FactoryBot.create(:review)
    end

    it "can be created" do
      expect(@review).to be_valid
    end

    it "can be created without a body or reviewer_name" do
      @review.body = nil
      @review.reviewer_name = nil

      expect(@review).to be_valid
    end

    it "cannot be created without a rating" do
      @review.rating = nil

      expect(@review).not_to be_valid
    end

    context "when rating is not an integer" do
      it "is invalid" do
        @review.rating = ''

        expect(@review).not_to be_valid
      end
    end

    context "when rating is greater than 5.0" do
      it "is invalid" do
        @review.rating = 10.0

        expect(@review).not_to be_valid
      end 
    end
  end
end