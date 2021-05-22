# frozen_string_literal: true

require "rails_helper"

RSpec.describe BooksController, type: :request do
  describe "#show" do
    let!(:book) { create(:book) }
    let!(:review) { create(:review, book: book) }
    let(:book_id) { book.id }

    subject(:request) { get book_url(book_id) }
    before(:each) do
      request
    end

    context "success" do
      context "with review" do
        it "has status code :success" do
          expect(response).to have_http_status(:success)
        end

        it "responds with JSON" do
          expect(response.content_type).to eql("application/json; charset=utf-8")
        end

        it "returns a Jsend body" do
          expect(JSON.parse(response.body)).to match(
            "status" => "success",
            "data" => {
              "book" => hash_including(
                "id" => book.id,
                "title" => book.title,
                "author" => book.author,
                "price" => book.price,
                "reviews" => [
                  hash_including(
                    "text" => review.text,
                    "score" => review.score,
                    "reviewed_by" => review.reviewed_by,
                  )
                ]
              )
            }
          )
        end
      end # context "with review"

      context "without review" do
        let!(:review) { nil }

        it "has status code :success" do
          expect(response).to have_http_status(:success)
        end

        it "responds with JSON" do
          expect(response.content_type).to eql("application/json; charset=utf-8")
        end

        it "returns a Jsend body" do
          expect(JSON.parse(response.body)).to match(
            "status" => "success",
            "data" => {
              "book" => hash_including(
                "id" => book.id,
                "title" => book.title,
                "author" => book.author,
                "price" => book.price,
                "reviews" => []
              )
            }
          )
        end
      end # context "without review"
    end # context "success"

    context "error" do
      context "when book is not found" do
        let(:book_id) { "invalid_id" }

        it "responds with an error message" do
          expect(JSON.parse(response.body)).to eq({
            "status" => "error",
            "message" => "book with id #{book_id} NOT FOUND"
          })
        end

        it "responds with status code :not_found (404)" do
          expect(response).to have_http_status(:not_found)
        end
      end # context "when book is not found"
    end # context "error"

  end # describe "#show"

  describe "#destroy" do
    let!(:book) { create(:book) }
    let(:book_id) { book.id }

    subject(:request) { delete book_url(book_id) }
    before(:each) do
      request
    end

    context "success" do
      it "has status code :success" do
        expect(response).to have_http_status(:success)
      end

      it "responds with JSON" do
        expect(response.content_type).to eql("application/json; charset=utf-8")
      end

      it "returns a Jsend body" do
        expect(JSON.parse(response.body)).to match(
          "status" => "success",
          "data" => nil,
        )
      end
    end # context "success"

    context "error" do
      context "when book is not found" do
        let(:book_id) { "invalid_id" }

        it "responds with an error message" do
          expect(JSON.parse(response.body)).to eq({
            "status" => "error",
            "message" => "couldn't DELETE book record with id #{book_id}"
          })
        end

        it "responds with status code :internal_server_error (500)" do
          expect(response).to have_http_status(:internal_server_error)
        end
      end # context "when book is not found"
    end # context "error"
  end # describe "#destroy"
end