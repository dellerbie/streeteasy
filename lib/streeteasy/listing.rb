require 'json'

class Listing
  attr_writer :address, :type, :price
  attr_accessor :url
  
  def initialize(attributes={})
    @address = attributes[:address] || ''
    @type = attributes[:type] || ''
    @price = attributes[:price] || 0
    @url = attributes[:url] || ''
  end
  
  def address
    if @address.nil? || @address.empty?
      ''
    else
      @address.sub(/(\w+floor$)|(#.*$)/i, '').strip
    end
  end
  
  def unit
    if @address.nil? || @address.empty?
      ''
    else
      _unit = @address.slice(/(\w+floor$)|(#.*$)/i)
      (_unit.nil? || _unit.empty?) ? '' : _unit.gsub('#', '')
    end
  end
  
  def price
    if @price.nil? || @price.to_s.empty?
      0
    else
      @price.to_s.gsub(/\D/, '').strip.to_i
    end
  end
  
  def type
    if @type.nil? || @type.empty?
      ''
    else
      @type.capitalize
    end
  end
  
  def to_s
    ["address: #{address}", "unit: #{unit}", "type: #{type}", "price: #{price}", "url: #{url}"].join("\n")
  end
  
  def to_json(*a)
    {
      listing_class: type, 
      address: address, 
      unit: unit, 
      url: url, 
      price: price
    }.to_json(*a)
  end
end
