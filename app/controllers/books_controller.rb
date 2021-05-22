class BooksController < ApplicationController
  # response follows Jsend specification: https://github.com/omniti-labs/jsend

  def index
    books = Book.all
    response = {
      "status" => "success",
      "data" => {
        "books" => books
      },
    }

    render json: response, status: :ok
  end

  def show
    id = params[:id]
    book = Book.find_by(id: id)

    if book
      response = {
        "status" => "success",
        "data" => {
          "book" => book.attributes.merge("reviews" => book.reviews)
        }
      }
      render json: response, status: :ok
    else
      response = { "status" => "error", "message" => "book with id #{id} NOT FOUND"}
      render json: response, status: :not_found
    end
  end

  def create
    book_params = {
      title: params[:title],
      author: params[:author],
      price: params[:price],
    }

    book = Book.new(book_params)
    if book.valid?
      book.save!
      response = { "status" => "success", "data" => book }
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

  def destroy
    id = params[:id]
    book = Book.find_by(id: id)

    if book && book.destroy
      response = { "status" => "success", "data" => nil }
      render json: response, status: :ok
    else
      response = { "status" => "error", "message" => "couldn't DELETE book record with id #{id}"}
      render json: response, status: :internal_server_error
    end
  end
end