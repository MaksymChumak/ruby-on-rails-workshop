class ReviewsController < ApplicationController
  # response follows Jsend specification: https://github.com/omniti-labs/jsend

  def create
    review_params = {
      text: params[:text],
      score: params[:score],
      reviewed_by: params[:reviewed_by],
      book_id: params[:book_id]
    }
    review = Review.new(review_params)
    if review.valid?
      review.save!
      response = { "status" => "success", "review" => review }
      render json: response, status: :ok
    else
      response = {
        "status" => "fail",
        "data" => {
          "message" => "invalid request body"
        }
      }
      render json: response, status: :bad_request
    end
  end

end