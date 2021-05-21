# frozen_string_literal: true

require "rails_helper"

RSpec.describe Review, type: :model do
  let(:book) { create(:book) }

  it "has a valid factory" do
    expect(build(:review, book: book).save).to be_truthy
  end
end
