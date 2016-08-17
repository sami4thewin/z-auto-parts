class ZAutoParts::Deal

  attr_accessor :name, :price, :description, :url

  @@deals = []

  def self.today
    self.scrape_deal_news
    self.scrape_prices
    self.scrape_description
    self.scrape_url
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
  end

  def self.scrape_url
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    output = doc.css(".content-specs > .button")

    output.each_with_index do |e,i|
      current_deal = @@deals[i]
      current_deal.url = e.attributes["href"].value
    end
    # doc.css(".content-specs > .button")[0].attributes['href'].value
    # href = doc.css('#block a')[0]["href"]
  end


end
