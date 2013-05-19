class PostOrder
  attr_accessor :city, :street, :house, :apartment, :destination, :value
  
  def initialize(city, street, house, apartment, destination, value)
    @city, @street, @house, @apartment, @destination, @value = city, street, house, apartment, destination, value
  end
end

class PostSorting
  attr_accessor :orders
  def initialize
    @orders = []
  end

  def add_post(new_order_sort) #передача пользовательских данных в @orders
    @orders << new_order_sort
  end

  def the_number_of_parcels_in_the_city(city) # 1) the number of parcels sent to some city 
    @orders.select { |order| order.city == city }.size   
  end

  def value_filter_10(value) # 2) how many parcels with value higher than 10 were sent
    value = 10
    @orders.select { |order| order.value > value }.size
  end

  def popular_address # 3) what is the most popular address
    adresses = Hash.new(0)
    @posts.each {|order| adresses["#{order.city} #{order.street} #{order.house} #{order.apartment}"] += 1 }
    adresses.max_by {|key,value| value}.first
  end 
end 

sorting = PostSorting.new
sorting.add_post(PostOrder.new("Pavlograd","Repina street","95","113","Oleg",10))
sorting.add_post(PostOrder.new("Dnepropetrovsk","Kamchatska street","1","14","Vano",15))
sorting.add_post(PostOrder.new("Solone","Kul street","5","0","Jeyson",1))
sorting.add_post(PostOrder.new("Petropalovka","Prog street","8","45","Viktor",3))
sorting.add_post(PostOrder.new("Petropalovka","Prog street","8","45","Viktor",3))
puts sorting.the_number_of_parcels_in_the_city("Petropalovka")
puts sorting.value_filter_10
puts sorting.popular_address

