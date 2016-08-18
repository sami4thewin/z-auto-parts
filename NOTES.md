class ZAutoParts::Deal

  attr_accessor :number, :name, :price, :description, :url

  @@deals = []

  def self.today
    self.scrape_deal_news
    self.scrape_prices
    self.scrape_description
    self.scrape_url
    @@deals
  end

  def self.scrape_deal_news
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    names = doc.css("h3.headline-xlarge")
    names.each do |part|
      x = self.new
      x.name = part.text
      # name = deal.text
      # x = Deal.new
      # x.name = name
      # x.value =
      # x.save
      @@deals << x
    end
    # binding.pry
    # @@deals
  # end
  end

  def self.scrape_prices
    #second iteration
    # i = 20
    # @@deals.each do |deal|
    #   deal.price = i
    #   i -= 1
    # end
    # binding.pry
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    prices = doc.css("div.content-call-out")
    i = 0
    if i < prices.length
  #     # binding.pry
      prices.each do |price|
  #     # binding.pry
        if new_price = /\$\d*/.match(price.text)
      # new_price = /\$\d*/.match(price.text)
          almost_price = new_price[0]
          almost_price.slice!"$"
          actual_price = almost_price.to_i
        else
          actual_price = 0
        # binding.pry
        end
  #
  #     binding.pry
  #     # actual_price = new_price[0]
  #     # price.at_css(".content-sub-call-out").remove
  #     # actual_price = price.text.strip

      current_deal = @@deals[i]
      current_deal.price = actual_price
      i += 1
      end
    end
  # @@deals
    # binding.pry
  end

  def self.scrape_description
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    description = doc.css("div.content-body")
    i = 0
    if i < description.length
      description.each do |bio|
        descriptor = bio.text
        current_deal = @@deals[i]
        current_deal.description = descriptor
        i += 1
      end
    end
    # description.each_with_index do |bio, i|
    #   descriptor = bio.text
    #   current_deal = @@deals[i]
    #   current_deal.description = descriptor
    #   i += 1
    # end
# binding.pry
# @@deals
  end

  def self.scrape_url
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    output = doc.css(".content-specs > .button")

    output.each_with_index do |e,i|
      current_deal = @@deals[i]
      current_deal.url = e.attributes["href"].value
      current_deal.number = i + 1
    end
    # binding.pry
    # @@deals
    # doc.css(".content-specs > .button")[0].attributes['href'].value
    # href = doc.css('#block a')[0]["href"]
  end

end









#Our CLI Controller

class ZAutoParts::CLI

  def call
    puts "Welcome, are you ready to save some money?".colorize(:red)
    # list_parts
    menu
    # goodbye
  end

  @@parts = nil

  def list_parts
    if @@parts == nil
      @@parts = ZAutoParts::Deal.today
    #this is a little trick by putting the (1) we don't have to put -1, it starts the index at 1.
    # @@parts.each.with_index(1) do |part, i|
    #   puts "#{i}. #{part.name.colorize(:blue)} - #{part.price}"
      tp @@parts, :number, {:name => {:width => 50}}, :price
      # binding.pry
    # end
    else
      tp @@parts, :number, {:name => {:width => 50}}, :price
    # @@parts.each.with_index(1) do |part, i|
    #   puts "#{i}. #{part.name.colorize(:blue)} - #{part.price}"
    # end
    end
  end

  def sort
    @@parts = @@parts.sort_by!{|part| part.price}
    y = 1
    @@parts.map do |part|
      part.number = y
      y +=1
    end
    @@parts
    # tp @@parts, :number, {:name => {:width => 50}}, :price
    # @@parts.each.with_index(1) do |part, i|
    #   puts "#{i}. #{part.name.colorize(:magenta)} - #{part.price}"
    # end
  end

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
        the_part = @@parts[input.to_i - 1]
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

  def goodbye
    puts "Happy shopping!".colorize(:yellow)
  end

end
