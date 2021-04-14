class AddReviewedByToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :reviewed_by, :string
  end
end
