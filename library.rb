class Users
  attr_accessor :name,:name_book, :order_date, :issue_date

  def initialize (name, book, order_date = Time.now, issue_date = nil)
    @name, @name_book, @order_date, @issue_date = name, name_book, order_date, issue_date
  end
end

class Library 
  attr_accessor :orders_book
  
  def initialize
    @orders_book = []
  end

  def add_order_book(new_order_book) #передача пользовательских данных в @orders_book 
    @orders_book << new_order_book 
  end

  def smallest_period # 1) the smallest period for which library found a book
    @orders_book.each{|order| if order.issue_date > 0 
      time = order.issue_date - order.order_date
      variable = time if time == nil end
    }
    Time.at(variable).getgm.strftime("%H:%M:%S")
  end

  def order_satisfied # 2) how many orders were not satisfied
    @orders_book.inject(0) { |counter, order| order.issue_date.nil? if ? counter + 1 : counter }
  end

  def regular_name(user) # 3) who often takes the book 
    users = Hash.new(0)
    @orders_book.each {|order| users[order.name] +=1 if order.name_book == user}
    user_popular = users.max_by {|key,value| value}.first  
  end

  def popular_book(*books) # 4) what is the most popular book
    books = Hash.new(0)
    @orders_book.each {|order| books[order.name_book] +=1}
    book_popular = books.max_by {|key,value| value}.first 
  end

  def number_people # 5) how many people ordered one of the three most popular books
    book_popular.size
  end
end

library = Library.new
library.add_order_book(Users.new("user1","book1",Time.now,Time.now+10))
library.add_order_book(Users.new("user2","book2",Time.now,Time.now+11))
library.add_order_book(Users.new("user3","book3",Time.now,Time.now+15))
library.add_order_book(Users.new("user4","book1",Time.now))
library.add_order_book(Users.new("user1","book1",Time.now,Time.now+10))
