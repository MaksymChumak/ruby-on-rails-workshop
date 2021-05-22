# frozen_string_literal: true

require "rails_helper"

RSpec.describe Review, type: :model do
  it "has a valid factory" do
    expect(build(:review).save).to be_truthy
  end
end
