Grocery Application
-------------------

Download app into local directory.
Use Ruby v2.0+
Run as "ruby grocery.rb"

Class: Checkout
  Instance Vars
    Basket - holds the items as checked out, a hash
    Rule - an array of the rules

  Methods
    - Initialize - reads in product rules file
    - Scan - an item read in
    - Validate - that the item is in the product rules file
    - Total - calculate total before & after discounts

Methods:

  Initialize(rules-file)
    Initializes the instance variables.
    This will read from a text file, the rules.
    The format of new rules are:

    <product id> <name> <price> <discount%> <items> <x41>

    Note: all values *must* have a number.
      product id - expected alphanumeric, no spaces
      name - alphanumeric, spaces are encoded with a "+"
      price - floating point number
      discount - % in floating point number
               - set default (if not used) to zero
      items - integer indicating when discount takes effect
            - set default (if not used) to zero
      x41 - integer indicating a a 2 for a "2 for 1", 3 for a "3 for 1"
          - default if not used set to 0 or 1

  Scan(item)
    Calls validate on item, if valid, adds to basket

  Total
    Read in the basket (class var)
    Perform price calculation based on rules file


  Validate(item)
    Given an item (product id number) checks the rules if valid
    Return true/false


  Since this is code v1, would recommend
    1. writing some automated tests
    2. refactoring the cumbersome total method
      - would probably turn rules into an array of hashes for human-readable keys, remove some of the cruft in there.
    3. Add validation for invalid rules format file.
    4. Add validation for missing rules file.
    5. If the site became high volume, would quiz the COO and CEO about how often they would like to be changing rules, maybe look at putting rules in cache.

  Would also inform the testing team that some of their test data is incorrect.
