class Book < ApplicationRecord
    BOOKS = [
        {
            id: 1,
            title: "Faust",
            author: "Johann Wolfgang von Goethe",
            price: 17.01,
        },
        {
            id: 2,
            title: "The Little Prince",
            author: "Antoine de Saint-Exupery",
            price: 16.99,
        },
        {
            id: 3,
            title: "The Last Lecture",
            author: "Randy Pausch",
            price: 17.78,
        },
        {
            id: 4,
            title: "The World of Yesterday",
            author: "Stefan Zweig",
            price: 33.95,
        },
        {
            id: 5,
            title: "Man's Search for Meaning",
            author: "Viktor E. Frankl",
            price: 25.69,
        },
    ]

    LAST_ID = BOOKS.length
end