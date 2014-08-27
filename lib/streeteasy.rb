require 'nokogiri'
require 'open-uri'
require 'net/http'

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
    url = "http://streeteasy.com/for-sale/#{neighborhood}?view=list"
    fetch_listings_from_url(url)
  end
  
  def most_expensive_rentals
    url = "http://streeteasy.com/for-rent/#{neighborhood}?view=list"
    fetch_listings_from_url(url)
  end
  
  def fetch_listings_from_url(url)
    doc = Nokogiri::HTML(open(url))
    # p doc
    
    # response = Net::HTTP.get_response(URI(url))
  end
end