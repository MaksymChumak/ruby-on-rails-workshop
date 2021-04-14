class NonfictionBooksController < ApplicationController
  # response follows Jsend specification: https://github.com/omniti-labs/jsend

  def create
    nonfiction_book_params = {
      title: params[:title],
      author: params[:author],
      price: params[:price],
    }

    nonfiction_book = NonfictionBook.new(nonfiction_book_params)
    if nonfiction_book.valid?
      nonfiction_book.save!
      response = { "status" => "success", "data" => nonfiction_book }
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
    nonfiction_books = NonfictionBook.all
    response = {
      "status" => "success",
      "data" => {
        "books" => nonfiction_books
      },
    }

    render json: response, status: :ok
  end
end