class BooksController < ApplicationController
  # response follows Jsend specification: https://github.com/omniti-labs/jsend

  def index
    response = {
      "status" => "success",
      "data" => {
        "books" => Book::BOOKS
      },
    }

    render json: response, status: :ok
  end

  def show
    id = params[:id].to_i
    book = Book::BOOKS.find { |b| b[:id] == id }

    if book
      response = { "status" => "success", "data" => book }
      render json: response, status: :ok
    else
      response = { "status" => "error", "message" => "book with id #{id} NOT FOUND"}
      render json: response, status: :not_found
    end
  end

  def create
    title = params[:title]
    price = params[:price]
    author = params[:author]
    if title && price && author
      Book::LAST_ID += 1

      book = {
        id: Book::LAST_ID,
        title: title,
        author: author,
        price: price,
      }

      Book::BOOKS.push(book)
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
    id = params[:id].to_i

    if Book::BOOKS.reject! { |b| b[:id] == id }
      response = { "status" => "success", "data" => nil }
      render json: response, status: :ok
    else
      response = { "status" => "error", "message" => "book with id #{id} NOT FOUND"}
      render json: response, status: :not_found
    end
  end
end