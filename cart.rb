require 'singleton'

module CartInterface
	def id() raise "price must be overridden"; end
  def price() raise "price must be overridden"; end
end

class Cart
	include Singleton
	attr_reader :items

	def initialize
		@items = {}
	end

	def add(product, quantity=1)
		if @items.key? product.id
			@items[product.id][:quantity] += quantity.to_i
		else
			@items[product.id] = { :product => product, :quantity => quantity.to_i }
		end
		return self
	end

	def remove(product_id, quantity=1)
		if @items.key? product_id
			if $quantity.to_i > @items[product_id][:quantity]
				@items.delete(product_id)
			end

			if @items[product_id][:quantity] > 1
				@items[product_id][:quantity] -= quantity.to_i
			else
				@items.delete(product_id)
			end
		end
	 	return self
	end

	def total
		sum = 0.00
	 	@items.each { |id, item| sum += item[:product].price * item[:quantity] }
		return sum
	end

	def quantity
		quantity = 0
		@items.each { |id, item| quantity += item[:quantity] } 
		return quantity
	end
end

class Product
	include CartInterface
	attr_accessor :id, :name, :price

	def initialize(id)
		@id = id
	end
end

product1 = Product.new(11)
product1.name = "Iphone"
product1.price = 10.00

product2 = Product.new(12)
product2.name = "Xbox"
product2.price = 5.00

cart = Cart.instance
cart.add(product2).add(product1,2)
cart.add(product2)
puts "you have #{cart.quantity} items in your cart! total = #{cart.total}"

cart.remove(12)
#ap cart.items
puts "you have #{cart.quantity} items in your cart! total = #{cart.total}"
cart.items.each { |id, item| puts "#{item[:product].name}\t|#{item[:product].price}\t|#{item[:quantity]}" }



