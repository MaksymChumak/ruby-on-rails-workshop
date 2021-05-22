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

    context "success" do
      it "has status code :success" do
        request
        expect(response).to have_http_status(:success)
      end

      it "responds with JSON" do
        request
        expect(response.content_type).to eql("application/json; charset=utf-8")
      end

      it "returns a Jsend body" do
        request
        expect(JSON.parse(response.body)).to match(
          "status" => "success",
          "data" => nil,
        )
      end

      it "deletes the book" do
        expect { request }.to change(Book, :count).by(-1)
      end
    end # context "success"

    context "error" do
      context "when book is not found" do
        let(:book_id) { "invalid_id" }

        it "responds with an error message" do
          request
          expect(JSON.parse(response.body)).to eq({
            "status" => "error",
            "message" => "couldn't DELETE book record with id #{book_id}"
          })
        end

        it "responds with status code :internal_server_error (500)" do
          request
          expect(response).to have_http_status(:internal_server_error)
        end
      end # context "when book is not found"
    end # context "error"
  end # describe "#destroy"

  describe "#create" do
    let(:title) { "cat book" }
    let(:author) { "cat_author" }
    let(:price) { 100 }

    let(:params) do
      {
        title: title,
        author: author,
        price: price,
      }
    end

    subject(:request) { post books_url(params) }

    shared_examples "invalid request" do
      it "responds with status code :bad_request (400)" do
        request
        expect(response).to have_http_status(:bad_request)
      end

      it "returns a Jsend body" do
        request
        expect(JSON.parse(response.body)).to match(
          "status" => "fail",
          "data" => {
            "message" => "invalid request body"
          }
        )
      end

      it "does not create a record in the database" do
        expect { request }.to_not change(Book, :count)
      end
    end # shared_examples "invalid request"

    context "success" do
      it "has status code :success" do
        request
        expect(response).to have_http_status(:success)
      end

      it "responds with JSON" do
        request
        expect(response.content_type).to eql("application/json; charset=utf-8")
      end

      it "returns a Jsend body" do
        request
        expect(JSON.parse(response.body)).to match(
          "status" => "success",
          "data" => hash_including(
            "title" => title,
            "author" => author,
            "price" => price,
          )
        )
      end

      it "creates a book" do
        expect { request }.to change(Book, :count).by(1)
      end
    end # context "success"

    context "error" do
      context "when title is not provided" do
        let(:title) { nil }

        it_behaves_like "invalid request"
      end # context "when title is not provided"

      context "when author is not provided" do
        let(:author) { nil }

        it_behaves_like "invalid request"
      end # context "when author is not provided"

      context "when price is not provided" do
        let(:price) { nil }

        it_behaves_like "invalid request"
      end # context "when price is not provided"
    end # context "error"
  end # describe "#create"

  describe "#index" do
    let!(:book) { create(:book) }
    let!(:book1) { create(:book) }

    subject(:request) { get books_url }

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
          "data" => {
            "books" => [
              hash_including(
                "id" => book.id,
                "title" => book.title,
                "author" => book.author,
                "price" => book.price,
              ),
              hash_including(
                "id" => book1.id,
                "title" => book1.title,
                "author" => book1.author,
                "price" => book1.price,
              )
            ]
          }
        )
      end
    end # context "success"
  end # describe "#index"
end