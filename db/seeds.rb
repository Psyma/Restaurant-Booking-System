# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

products = [
    { name: "Fried Chicken", cooking_time: "12", price: "125", is_available: 1, filename: "menu1.jpg", filepath: "assets/images/img/menu-1.jpg" },
    { name: "Beef Jerky", cooking_time: "15", price: "225", is_available: 1, filename: "menu2.jpg", filepath: "assets/images/img/menu-2.jpg" },
    #{ name: "Quesadilla", cooking_time: "25", price: "223", is_available: 1, filename: "menu3.jpg", filepath: "assets/images/img/menu-3.jpg" },
    #{ name: "Philly Cheesesteak", cooking_time: "30", price: "159", is_available: 1, filename: "menu4.jpg", filepath: "assets/images/img/menu-4.jpg" },
    #{ name: "Tortelloni", cooking_time: "23", price: "268", is_available: 1, filename: "menu5.jpg", filepath: "assets/images/img/menu-5.jpg" },
    #{ name: "BBQ Briske", cooking_time: "15", price: "158", is_available: 1, filename: "menu6.jpg", filepath: "assets/images/img/menu-6.jpg" },
    #{ name: "Stuffed Manicotti", cooking_time: "199", price: "249", is_available: 1, filename: "menu7.jpg", filepath: "assets/images/img/menu-7.jpg" },
    #{ name: "Nachos", cooking_time: "18", price: "99", is_available: 1, filename: "menu8.jpg", filepath: "assets/images/img/menu-8.jpg" },
]

User.create(first_name: "admin", last_name: "admin", email: "admin@admin.com", address: "3187 Golden Ridge Road", password: "password", role: 1)
    10.times do
        products.shuffle!
        products.each do |product|
            name = product[:name]
            cooking_time = product[:cooking_time]
            price = product[:price]
            is_available = product[:is_available]
            reservation_id = -1
            filename = product[:filename]
            filepath = product[:filepath]

            product = Product.create(name: name, cooking_time: cooking_time, price: price, is_available: is_available)
            product.image.attach('filename': filename, io: File.open(Rails.root.join('app', filepath)))
    end 
end    