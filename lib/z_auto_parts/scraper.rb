class Scraper

  def scrape_recipes
    recipes = []
    recipes << self.scrape_simply

    #go to simple recipes, find the recipes, extract the properties, instantiate a recipe

    recipes
  end

  def scrape_simply
    doc = Nokogiri::HTML(open("https://www.ebizmba.com/articles/recipe-websites"))
    binding.pry
  end

end
