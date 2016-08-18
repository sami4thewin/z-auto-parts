# #Our CLI Controller
#
class ZAutoParts::CLI
#
  attr_accessor :parts

  def call
    puts "Welcome, are you ready to save some money?".colorize(:red)
    make_deals
#     list_parts
    menu
#     goodbye
  end

  def make_deals
    deals_array = ZAutoParts::Scraper.today
    @parts = ZAutoParts::Deal.create_from_collection(deals_array)
  end
#






# #Our CLI Controller
#
# class ZAutoParts::CLI
#
#   def call
#     puts "Welcome, are you ready to save some money?".colorize(:red)
#     # list_parts
#     menu
#     # goodbye
#   end
#
#   @@parts = nil
#
  def list_parts
    # if @@parts == nil
    #   @@parts = ZAutoParts::Deal.today
    # #this is a little trick by putting the (1) we don't have to put -1, it starts the index at 1.
    # # @@parts.each.with_index(1) do |part, i|
    # #   puts "#{i}. #{part.name.colorize(:blue)} - #{part.price}"
    #   tp @@parts, :number, {:name => {:width => 50}}, :price
    #   # binding.pry
    # # end
    # else
      tp self.parts, :number, {:name => {:width => 50}}, :price
    # @@parts.each.with_index(1) do |part, i|
    #   puts "#{i}. #{part.name.colorize(:blue)} - #{part.price}"
    # end
    # end
  end
#
  def sort
    # binding.pry
    @parts = @parts.sort_by!{|part| part.price}
    # y = 1
    # @@parts.map do |part|
    #   part.number = y
    #   y += 1
    # end
    reassign_numbers
    # tp @@parts, :number, {:name => {:width => 50}}, :price
    # @@parts.each.with_index(1) do |part, i|
    #   puts "#{i}. #{part.name.colorize(:magenta)} - #{part.price}"
    # end
  end
#
  def reassign_numbers
    @parts.each_with_index do |part, i|
      part.number = i + 1
    end
  end
#
#
#
  def menu
    input = nil
    x = nil
    list_parts
    if input == "exit"
      goodbye
    # end
    elsif input != "exit"
      puts "Enter the position of the part you'd like more info on, or type sort to configure by price from lowest to highest, or type exit:".colorize(:magenta)
      input = gets.strip.downcase
      if input == "exit"
        goodbye

      #this is so if you put in a string, it won't read as an integer. This is because the .to_i value of a string is 0.
      elsif input.to_i > 0
        the_part = @parts[input.to_i - 1]
        puts "#{the_part.name.colorize(:red)} - #{the_part.price} - #{the_part.description.colorize(:blue)}"
        puts "Would you like to launch this page? Type yes or no.".colorize(:blue)
        x = gets.strip.downcase
        if x == "yes"
          Launchy.open(the_part.url)
          menu
        elsif x == "no"
          menu
        else
          puts "Please enter a valid command.".colorize(:green)
        end
      elsif input == "sort"
        sort
        menu
      else
        if input != "exit"
        puts "Please enter valid command.".colorize(:green)
      end
    end
  end
  end
#
  def goodbye
    puts "Happy shopping!".colorize(:yellow)
  end
#
end








# #Our CLI Controller
#
# class ZAutoParts::CLI
#
#   def call
#     puts "Welcome, are you ready to save some money?".colorize(:red)
#     # list_parts
#     menu
#     # goodbye
#   end
#
#   @@parts = nil
#
#   def list_parts
#     if @@parts == nil
#       @@parts = ZAutoParts::Deal.today
#     #this is a little trick by putting the (1) we don't have to put -1, it starts the index at 1.
#     # @@parts.each.with_index(1) do |part, i|
#     #   puts "#{i}. #{part.name.colorize(:blue)} - #{part.price}"
#       tp @@parts, :number, {:name => {:width => 50}}, :price
#       # binding.pry
#     # end
#     else
#       tp @@parts, :number, {:name => {:width => 50}}, :price
#     # @@parts.each.with_index(1) do |part, i|
#     #   puts "#{i}. #{part.name.colorize(:blue)} - #{part.price}"
#     # end
#     end
#   end
#
#   def sort
#     @@parts = @@parts.sort_by!{|part| part.price}
#     # y = 1
#     # @@parts.map do |part|
#     #   part.number = y
#     #   y += 1
#     # end
#     reassign_numbers(@@parts)
#     # tp @@parts, :number, {:name => {:width => 50}}, :price
#     # @@parts.each.with_index(1) do |part, i|
#     #   puts "#{i}. #{part.name.colorize(:magenta)} - #{part.price}"
#     # end
#   end
#
#   def reassign_numbers(parts)
#     parts.each_with_index do |part, i|
#       part.number = i + 1
#     end
#   end
#
#
#
#   def menu
#     input = nil
#     x = nil
#     list_parts
#     if input == "exit"
#       goodbye
#     # end
#     elsif input != "exit"
#       puts "Enter the position of the part you'd like more info on, or type sort to configure by price from lowest to highest, or type exit:".colorize(:magenta)
#       input = gets.strip.downcase
#       if input == "exit"
#         goodbye
#
#       #this is so if you put in a string, it won't read as an integer. This is because the .to_i value of a string is 0.
#       elsif input.to_i > 0
#         the_part = @@parts[input.to_i - 1]
#         puts "#{the_part.name.colorize(:red)} - #{the_part.price} - #{the_part.description.colorize(:blue)}"
#         puts "Would you like to launch this page? Type yes or no.".colorize(:blue)
#         x = gets.strip.downcase
#         if x == "yes"
#           Launchy.open(the_part.url)
#           menu
#         elsif x == "no"
#           menu
#         else
#           puts "Please enter a valid command.".colorize(:green)
#         end
#       elsif input == "sort"
#         sort
#         menu
#       else
#         if input != "exit"
#         puts "Please enter valid command.".colorize(:green)
#       end
#     end
#   end
#   end
#
#   def goodbye
#     puts "Happy shopping!".colorize(:yellow)
#   end
#
# end
