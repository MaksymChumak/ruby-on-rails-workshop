# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_books
  books = [
    {
      title: "Faust",
      author: "Johann Wolfgang von Goethe",
      price: 17.01,
    },
    {
      title: "The Little Prince",
      author: "Antoine de Saint-Exupery",
      price: 16.99,
    },
    {
      title: "The Last Lecture",
      author: "Randy Pausch",
      price: 17.78,
    },
    {
      title: "The World of Yesterday",
      author: "Stefan Zweig",
      price: 33.95,
    },
    {
      title: "Man's Search for Meaning",
      author: "Viktor E. Frankl",
      price: 25.69,
    }
  ]

  books.each { |b| Book.create!(b) }
end

create_books