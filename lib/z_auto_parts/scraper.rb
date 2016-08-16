class Scraper

  def scrape_deals
    deals = []
    deals << self.scrape_deal_news

    #go to simple recipes, find the recipes, extract the properties, instantiate a recipe

    deals
  end

  def scrape_deal_news
    doc = Nokogiri::HTML(open("https://www.ebizmba.com/articles/recipe-websites"))
    binding.pry
  end

end
