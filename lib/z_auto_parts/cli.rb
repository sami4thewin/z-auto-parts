#Our CLI Controller

class ZAutoParts::CLI

  def call
    puts "Welcome, are you ready to save some money?"
    list_parts
    menu
    goodbye
  end

  @@parts = nil

  def list_parts
    if @@parts == nil
    @@parts = ZAutoParts::Deal.today
    #this is a little trick by putting the (1) we don't have to put -1, it starts the index at 1.
    @@parts.each.with_index(1) do |part, i|
      puts "#{i}. #{part.name} - #{part.price}"
      # binding.pry
    end
  else
    @@parts.each.with_index(1) do |part, i|
      puts "#{i}. #{part.name} - #{part.price}"
    end
  end
  end

  def sort
    @@parts = @@parts.sort_by!{|part| part.price}
    @@parts.each.with_index(1) do |part, i|
      puts "#{i}. #{part.name} - #{part.price}"
    end
  end

  def menu
    input = nil
    x = nil
    list_parts
    while input != "exit"
      puts "Enter the number of the part you'd like more info on, or type sort to configure by price from lowest to highest, or type exit:"
      input = gets.strip.downcase
      #this is so if you put in a string, it won't read as an integer. This is because the .to_i value of a string is 0.
      if input.to_i > 0
        the_part = @@parts[input.to_i - 1]
        puts "#{the_part.name} - #{the_part.price} - #{the_part.description}"
        puts "Would you like to launch this page? Type yes or no."
        x = gets.strip.downcase
        if x == "yes"
          Launchy.open(the_part.url)
          menu
        elsif x == "no"
          menu
        else
          puts "Please enter a valid command."
        end
      elsif input == "sort"
        sort
      else
        puts "Please enter valid command."
      end
    end
  end

  def goodbye
    puts "Happy shopping!"
  end

end
