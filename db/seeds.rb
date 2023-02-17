Comment.delete_all
Notification.delete_all
OrderProduct.delete_all
Order.delete_all
Product.delete_all
Reservation.delete_all
User.delete_all
ActionMailer::Base.perform_deliveries = false

@test = true

def set_users()
    if @test
        admin = User.create(first_name: "admin", last_name: "admin", email: "admin@admin.com", address: "3187 Golden Ridge Road", password: "password", confirmed_at: Time.now, role: Roles::ADMIN)
        user = User.create(first_name: "dummy", last_name: "dummy", email: "dummy@dummy.com", address: "3187 Golden Ridge Road", password: "password", confirmed_at: Time.now, role: Roles::CUSTOMER)
    
        admin.image.attach('filename': 'profile.png', io: File.open(Rails.root.join('app', 'assets/images/default_profile.png')))
        user.image.attach('filename': 'profile.png', io: File.open(Rails.root.join('app', 'assets/images/default_profile.png')))
    else
        admin = User.create(first_name: "admin", last_name: "admin", email: "admin@admin.com", address: "3187 Golden Ridge Road", password: "password", confirmed_at: Time.now, role: Roles::ADMIN)
        admin.image.attach('filename': 'profile.png', io: File.open(Rails.root.join('app', 'assets/images/default_profile.png')))
        rand(5..12).times do
            user = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.email, address: Faker::Address.full_address, password: "password", confirmed_at: Time.now, role: Roles::CUSTOMER)
            user.image.attach('filename': 'profile.png', io: File.open(Rails.root.join('app', 'assets/images/default_profile.png')))
        end 
    end
end

def set_testimonials()
    users = User.all()
    users.each do |user|
        rand(1..2).times do 
            comment = Comment.new(:contents => Faker::Lorem.sentence(word_count: 20))
            user.comments << comment
            comment.save
        end
    end 
end

def set_products()
    if @test
        products = [ 
            { name: "Fried Chicken", cooking_time: "12", price: "99", is_available: 1, filename: "menu1.jpg", filepath: "assets/images/img/menu-1.jpg" },  
        ]
    else
        products = [ 
            { name: "Fried Chicken", cooking_time: "12", price: "99", is_available: 1, filename: "menu1.jpg", filepath: "assets/images/img/menu-1.jpg" }, 
            { name: "Fried Chicken", cooking_time: "12", price: "99", is_available: 1, filename: "menu1.jpg", filepath: "assets/images/img/menu-1.jpg" },
            { name: "Beef Jerky", cooking_time: "15", price: "149", is_available: 1, filename: "menu2.jpg", filepath: "assets/images/img/menu-2.jpg" },
            { name: "Quesadilla", cooking_time: "25", price: "79", is_available: 1, filename: "menu3.jpg", filepath: "assets/images/img/menu-3.jpg" },
            { name: "Philly Cheesesteak", cooking_time: "30", price: "125", is_available: 1, filename: "menu4.jpg", filepath: "assets/images/img/menu-4.jpg" },
            { name: "Tortelloni", cooking_time: "23", price: "199", is_available: 1, filename: "menu5.jpg", filepath: "assets/images/img/menu-5.jpg" },
            { name: "BBQ Briske", cooking_time: "15", price: "189", is_available: 1, filename: "menu6.jpg", filepath: "assets/images/img/menu-6.jpg" },
            { name: "Stuffed Manicotti", cooking_time: "89", price: "89", is_available: 1, filename: "menu7.jpg", filepath: "assets/images/img/menu-7.jpg" },
            { name: "Nachos", cooking_time: "18", price: "99", is_available: 1, filename: "menu8.jpg", filepath: "assets/images/img/menu-8.jpg" }, 
        ]
    end

    @count = 2
    if @test
        @count = 1
    end

    @count.times do
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

end 

def set_reservations()
    users = User.all.where(role: Roles::CUSTOMER)
    users.each do |user|
        reservation = Reservation.new(:date => (Date.today + rand(365)).strftime("%m/%d/%Y"))
        reservation.status = Status::PENDING
        user.reservations << reservation
        reservation.save

        # customer notificaiton
        notification = Notification.new(:title => "Pending", :content => "You have booked a table, waiting for confirmation ...", :seen => Seen::NOT_SEEN)
        notification.save
        user.notifications << notification

        # admin notification
        admin = User.where(role: Roles::ADMIN).first
        notification = Notification.new(:title => "Booked", :content => "#{user.first_name} has booked a table, waiting for a confirmation", :seen => Seen::NOT_SEEN)
        notification.save
        admin.notifications << notification

        product_ids = []
        total_amount = 0

        order = Order.new() 
        count = Product.count
        2.times do  
            offset = rand(count) 
            product = Product.offset(offset).first
            total_amount += product.price.to_i 
            order_product = OrderProduct.new(:product_id => product.id)
            order.order_products << order_product
            order_product.save
        end

        order.total_amount = total_amount
        reservation.order = order 
    end
end

set_users()
set_products()
if !@test
    set_reservations()
end
set_testimonials()
