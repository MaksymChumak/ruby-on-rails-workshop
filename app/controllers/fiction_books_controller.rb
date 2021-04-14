class FictionBooksController < ApplicationController
  # response follows Jsend specification: https://github.com/omniti-labs/jsend

  def create
    fiction_book_params = {
      title: params[:title],
      author: params[:author],
      price: params[:price],
    }

    fiction_book = FictionBook.new(fiction_book_params)
    if fiction_book.valid?
      fiction_book.save!
      response = { "status" => "success", "data" => fiction_book }
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

  def index
    fiction_books = FictionBook.all
    response = {
      "status" => "success",
      "data" => {
        "books" => fiction_books
      },
    }

    render json: response, status: :ok
  end
end