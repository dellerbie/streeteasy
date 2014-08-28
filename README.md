streeteasy
==========

Installation
==========
This gem was tested with ruby 2.0.0p247

```ruby
gem build streeteasy.gemspec
gem install --dev ./streeteasy-0.0.1.gem
```

**NOTE: In order to execute the binary script, you will have to refresh your shell after installing the gem.**

Run the Tests
==========
```ruby
rake
```

Run the Script
==========
```ruby
streeteasy -h
streeteasy --neighborhood soho --limit 20 --output most_expensive.json
```

This will create a file "most_expensive_listings.json" in your current directory