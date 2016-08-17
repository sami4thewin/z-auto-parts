#Our CLI Controller

class ZAutoParts::CLI

  def call
    list_parts
    menu
    goodbye
  end

  def list_parts
    #get recipes
    # using here doc, google it, it's just like a giant string
    puts "Welcome, are you ready to save some money?"
    # puts <<-DOC.gsub /^\s*/, ''
    # 1. Chicken - Make chicken.
    # 2. Steak - Make steak.
    # DOC
    @parts = ZAutoParts::Deal.today
    binding.pry
    #this is a little trick by putting the (1) we don't have to put -1, it starts the index at 1.
    @parts.each.with_index(1) do |part, i|
      puts "#{i}. #{part.name} - #{part.price}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the part you'd like more info on or type list to see parts again or type exit:"
      input = gets.strip.downcase
      #this is so if you put in a string, it won't read as an integer. This is because the .to_i value of a string is 0.
      if input.to_i > 0
        the_part = @parts[input.to_i - 1]
        puts "#{the_part.name} - #{the_part.price} - #{the_part.description} -#{the_part.url}"
      elsif input == "list"
        list_parts
      else
        puts "Please enter valid command"
      # case input
      # when "1"
      #   puts "More info on recipe 1..."
      # when "2"
      #   puts "More info on recipe 2..."
      # when "list"
      #   list_recipes
      # else
      #   puts "Please enter valid command"
      end
    end
  end

  def goodbye
    puts "Happy shopping!"
  end

end
