# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, type: :model do

  it "has a valid factory" do
    expect(build(:book).save).to be_truthy
  end
end
