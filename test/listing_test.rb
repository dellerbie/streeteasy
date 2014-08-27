require 'test/unit'
require 'streeteasy'

class ListingTest < Test::Unit::TestCase
  def test_initialize_with_defaults
    listing = Listing.new
    assert_equal '', listing.address
    assert_equal '', listing.unit
    assert_equal '', listing.type
    assert_equal '', listing.url
    assert_equal 0, listing.price
  end
  
  def test_initialize 
    attributes = {address: '7 Wooster Street #PH', type: 'rental', price: '$7,375,000', url: "http://streeteasy.com/sale/1098553-condo-7-wooster-street-soho-new-york"}
    listing = Listing.new(attributes)
    
    assert_equal '7 Wooster Street', listing.address
    assert_equal 'PH', listing.unit
    assert_equal 'Rental', listing.type
    assert_equal 7375000, listing.price
    assert_equal "http://streeteasy.com/sale/1098553-condo-7-wooster-street-soho-new-york", listing.url
  end
  
  def test_address
    listing = Listing.new
    listing.address = "7 Wooster Street #PH"
    assert_equal "7 Wooster Street", listing.address
    
    listing.address = "362 West Broadway #2FLR"
    assert_equal "362 West Broadway", listing.address
    
    listing.address = "115 Spring Street 2NDFLOOR"
    assert_equal "115 Spring Street", listing.address
  end
  
  def test_unit
    listing = Listing.new
    listing.address = "7 Wooster Street #PH"
    assert_equal "PH", listing.unit
    
    listing.address = "362 West Broadway #2FLR"
    assert_equal "2FLR", listing.unit
    
    listing.address = "115 Spring Street 2NDFLOOR"
    assert_equal "2NDFLOOR", listing.unit
  end
  
  def test_type
    listing = Listing.new
    listing.type = 'sale'
    assert_equal 'Sale', listing.type
  end
  
  def test_price
    listing = Listing.new
    listing.price = ' $6,495,000  '
    assert_equal 6495000, listing.price
  end
end