class Review < ApplicationRecord
  validates :text, presence: true
  validates :score, presence: true
  validates :reviewed_by, presence: true
  validates :score, numericality: { less_than_or_equal_to: 100, only_integer: true }

  belongs_to :book
end