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
      assert_not_nil sales
      assert_equal se.max_results_per_listing_type, sales.length
    end
  end
  
  def test_most_expensive_rentals
    se = StreetEasy.new
    VCR.use_cassette('rentals') do
      rentals = se.most_expensive_rentals
      assert_not_nil rentals
      assert_equal se.max_results_per_listing_type, rentals.length
    end
  end
  
  def test_export_listings_to_file
    filename = "test/fixtures/#{StreetEasy::DEFAULT_OUTPUT_FILE}"
    se = StreetEasy.new(output: filename)
    puts "output file => #{se.output_file}"
    assert !File.exists?(filename), "Output file should not exist"
    
    begin
      VCR.use_cassette('sales') do
        sales = se.most_expensive_sales
        se.export_listings_to_file(sales)
        assert File.exists?(filename), "Output file should exist"
        assert !File.zero?(filename), "Output file should not be size zero"
      end
    ensure
      File.delete(filename) if File.exists?(filename)
    end
  end
  
end