require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'streeteasy/listing'

class StreetEasy
  DEFAULT_OUTPUT_FILE = "streeteasy_most_expensive_listings.json"
  DEFAULT_MAX_RESULTS_PER_LISTING_TYPE = 20
  DEFAULT_NEIGHBORHOOD = 'soho'
  
  attr_accessor :output_file, :max_results_per_listing_type, :neighborhood
  
  def initialize(options={})
    @output_file = options[:output] || DEFAULT_OUTPUT_FILE
    @max_results_per_listing_type = options[:limit] || DEFAULT_MAX_RESULTS_PER_LISTING_TYPE
    @neighborhood = options[:neighborhood] || DEFAULT_NEIGHBORHOOD
  end
  
  def most_expensive_listings
    most_expensive_sales.concat(most_expensive_rentals)
  end
  
  def most_expensive_sales
    fetch_listings_of_type(:sale)
  end
  
  def most_expensive_rentals
    fetch_listings_of_type(:rent)
  end
  
  def fetch_listings_of_type(listing_type)
    listings = []
    
    url = "http://streeteasy.com/for-#{listing_type.to_s}/#{neighborhood}?view=list"
    doc = Nokogiri::HTML(open(url))
    doc.css('#results table.listings tr.listing').each do |listing_node|
      address = listing_node.css('td h5 a').first.text
      url = "http://streeteasy.com#{listing_node.css('td h5 a').first['href']}"
      price = listing_node.css('td.price h5').first.text
      
      listings << Listing.new(address: address, type: listing_type, url: url, price: price)
    end
    
    listings.take(max_results_per_listing_type)
  end
end