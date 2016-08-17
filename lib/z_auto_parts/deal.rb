class ZAutoParts::Deal

  attr_accessor :name, :price, :description, :url

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
    i = 20
    @@deals.each do |deal|
      deal.price = i
      i -= 1
    end
    # binding.pry
  #   doc = Nokogiri::HTML(open("http://dealnews.com/c238/Automotive/"))
  #   prices = doc.css("div.content-call-out")
  #   i = 0
  #   if i < prices.length
  #     # binding.pry
  #   prices.each do |price|
  #     # binding.pry
  #     new_price = /\$\d*/.match(price.text)
  #     almost_price = new_price[0]
  #     almost_price.slice!"$"
  #     actual_price = almost_price.to_i
  #
  #     binding.pry
  #     # actual_price = new_price[0]
  #     # price.at_css(".content-sub-call-out").remove
  #     # actual_price = price.text.strip

  #     current_deal = @@deals[i]
  #     current_deal.price = actual_price
  #     i += 1
  #   end
  # end
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
    end
    # binding.pry
    # @@deals
    # doc.css(".content-specs > .button")[0].attributes['href'].value
    # href = doc.css('#block a')[0]["href"]
  end


end
