require 'test/unit'
require 'vcr'
require 'streeteasy'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

class StreetEasyTest < Test::Unit::TestCase
  def test_initialize_with_defaults
    se = StreetEasy.new
    assert_equal StreetEasy::DEFAULT_OUTPUT_FILE, se.output_file
    assert_equal StreetEasy::DEFAULT_MAX_RESULTS_PER_LISTING_TYPE, se.max_results_per_listing_type
    assert_equal StreetEasy::DEFAULT_NEIGHBORHOOD, se.neighborhood
  end
  
  def test_initialize_with_options
    options = {output: 'test_file.json', limit: 10, neighborhood: 'tribeca'}
    se = StreetEasy.new(options)
    assert_equal options[:output], se.output_file
    assert_equal options[:limit], se.max_results_per_listing_type
    assert_equal options[:neighborhood], se.neighborhood
  end
  
  def test_most_expensive_sales
    se = StreetEasy.new
    VCR.use_cassette('sales') do
      sales = se.most_expensive_sales
      puts sales
    end
  end
  
end