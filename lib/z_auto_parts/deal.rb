class ZAutoParts::Deal

  attr_accessor :name, :price, :description

  @@deals = []

  def self.today
    self.scrape_deal_news
    self.scrape_prices
    #scrape simple recipes and then return recipes based on that data

    #return a bunch of recipes
    # puts <<-DOC.gsub /^\s*/, ''
    # 1. Chicken - Make chicken.
    # 2. Steak - Make steak.
    # DOC

    # recipe_1 = self.new
    # recipe_1.name = "Chicken"
    # recipe_1.recipe = "Make chicken."
    #
    # recipe_2 = self.new
    # recipe_2.name = "Steak"
    # recipe_2.recipe = "Make steak."
    #
    # [recipe_1, recipe_2]
  end

  # def self.scrape_deals
    #the stubbed code above which is the properties, should be scraped here
    # deals = []
    # deals << self.scrape_deal_news

    #go to simple recipes, find the recipes, extract the properties, instantiate a recipe

    # deals
  # end

  def self.scrape_deal_news
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    # each = doc.search("div.content-view content-box content-wide")
    # first iteration
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
  # end
  end

  def self.scrape_prices
    #second iteration
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    prices = doc.css("div.content-call-out")
    i = 0
    if i < prices.length
    prices.each do |price|
      price.at_css(".content-sub-call-out").remove
      actual_price = price.text.strip
      current_deal = @@deals[i]
      current_deal.price = actual_price
      i += 1
    end
  end
    # prices[0].at_css(".content-sub-call-out").remove
    # actual_price = prices[0].text.strip

    binding.pry
    # i = 0
    #  if i < prices.length
    #   current_deal = @@deals[i]
    #   current_deal.price = prices[i].text
    #   i += 1
    # end
  end


end
