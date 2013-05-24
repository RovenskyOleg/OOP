class Users
  attr_accessor :name,:name_book, :order_date, :issue_date

  def initialize (name, name_book, order_date = Time.now, issue_date = nil)
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
  # 1) the smallest period for which library found a book

  def delay_smallest_period
    if  @issue_date 
      x.issue_date - x.order_date
    else
      nil
    end
  end

  def smallest_period 
    delay_smallest_period = @orders_book.select { |x| x.delay_smallest_period }
    delay_smallest_period.compact!
    delay_smallest_period.min
    Time.at(delay_smallest_period).getgm.strftime("%H:%M:%S")
  end

  def order_satisfied
    @orders_book.select { |x| x.issue_date == nil }.size
  end
  
  #Как альтернатива 2-му методу (вопрос c хешами не работает?)
  #def order_satisfied_variant_2()
   # a = @orders_book.size
    #@orders_book.compact! # удаление nil
    #b = @orders_book.size
    #value = a - b
  #end

  def regular_name(book) # 3) who often takes the book 
    users = Hash.new(0)
    @orders_book.each {|order| users[order.name] +=1 if book == order.name_book}
    user = users.max_by {|key,value| value}.first  
  end

  def popular_book(*books) # 4) what is the most popular book
    books = Hash.new(0)
    @orders_book.each {|order| books[order.name_book] +=1}
    book_popular = books.max_by {|key,value| value}.first 
  end

  def number_people # 5) how many people ordered one of the three most popular books
    books = Hash.new(0)
    @orders_book.each {|order| books[order.name_book] +=1}
    books.sort_by{|key, value| value}.last
  end
end

library = Library.new
library.add_order_book(Users.new("user1","book1",Time.now,Time.now+10))
library.add_order_book(Users.new("user2","book2",Time.now,Time.now+11))
library.add_order_book(Users.new("user3","book3",Time.now,Time.now+15))
library.add_order_book(Users.new("user4","book1",Time.now))
library.add_order_book(Users.new("user1","book1",Time.now,Time.now+10))
puts "The smallest period for which library found a book:"
puts library.smallest_period
puts "How many orders were not satisfied:"
puts library.order_satisfied
puts "Who often takes the book:"
puts library.regular_name("book1")
puts "What is the most popular book:"
puts library.popular_book()
puts "How many people ordered one of the three most popular books:"
puts library.number_people()