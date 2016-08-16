class ZAutoParts::Deal

  attr_accessor :name, :description

  def self.today
    self.scrape_deals
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

  def self.scrape_deals
    #the stubbed code above which is the properties, should be scraped here
    deals = []
    deals << self.scrape_deal_news

    #go to simple recipes, find the recipes, extract the properties, instantiate a recipe

    deals
  end

  def self.scrape_deal_news
    doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
    binding.pry
  end


end
