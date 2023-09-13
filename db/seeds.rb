# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

customer_1 = Customer.create!(first_name: "Bob", last_name: "Smith", email: "bs@bs.com", address: "123 Main St")
customer_2 = Customer.create!(first_name: "Sally", last_name: "Smith", email: "ss@ss.com", address: "123 Main St")
customer_3 = Customer.create!(first_name: "Joe", last_name: "Smith", email: "js@js.com", address: "789 Main St")
customer_4 = Customer.create!(first_name: "Dan", last_name: "Smith", email: "ds@ds.com", address: "789 Main St")

tea_1 = Tea.create!(title: "Green Tea", description: "Green tea is great.", temperature: 180, brew_time: 3)
tea_2 = Tea.create!(title: "Black Tea", description: "Black tea is great.", temperature: 200, brew_time: 5)
tea_3 = Tea.create!(title: "Oolong Tea", description: "Oolong tea is great.", temperature: 190, brew_time: 4)
tea_4 = Tea.create!(title: "White Tea", description: "White tea is great.", temperature: 185, brew_time: 3)

sub_1 = Subscription.create!(title: "Green Tea Monthly", price: 10.00, status: 0, frequency: "Monthly", tea_id: tea_1.id, customer_id: customer_1.id)
sub_2 = Subscription.create!(title: "Black Tea Monthly", price: 10.00, status: 0, frequency: "Monthly", tea_id: tea_2.id, customer_id: customer_1.id)
sub_3 = Subscription.create!(title: "Oolong Tea Monthly", price: 20.00, status: 1, frequency: "Monthly", tea_id: tea_3.id, customer_id: customer_1.id)
sub_4 = Subscription.create!(title: "White Tea Weekly", price: 50.00, status: 0, frequency: "Weekly", tea_id: tea_4.id, customer_id: customer_1.id)
sub_5 = Subscription.create!(title: "Green Tea Yearly", price: 2.00, status: 0, frequency: "Yearly", tea_id: tea_1.id, customer_id: customer_2.id)
sub_6 = Subscription.create!(title: "Oolong Tea Weekly", price: 14.00, status: 1, frequency: "Weekly", tea_id: tea_3.id, customer_id: customer_2.id)
sub_7 = Subscription.create!(title: "Black Tea Monthly", price: 10.00, status: 0, frequency: "Monthly", tea_id: tea_2.id, customer_id: customer_3.id)
sub_8 = Subscription.create!(title: "Green Tea Monthly", price: 10.00, status: 0, frequency: "Monthly", tea_id: tea_1.id, customer_id: customer_4.id)
sub_9 = Subscription.create!(title: "Black Tea Monthly", price: 10.00, status: 0, frequency: "Monthly", tea_id: tea_2.id, customer_id: customer_4.id)
sub_10 = Subscription.create!(title: "Oolong Tea Monthly", price: 20.00, status: 1, frequency: "Monthly", tea_id: tea_3.id, customer_id: customer_4.id)