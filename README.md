streeteasy
==========

Installation
==========
gem build streeteasy.gemspec
gem install --dev ./streeteasy-0.0.1.gem

Run Tests
==========
```ruby
rake
```

Run Script
==========
```ruby
streeteasy -h
streeteasy --neighborhood soho --limit 20 --output most_expensive.json
```

This will create a file "most_expensive_listings.json" in your current directory