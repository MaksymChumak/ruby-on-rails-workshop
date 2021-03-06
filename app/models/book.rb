class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :price, presence: true

  has_many :reviews, dependent: :destroy
end