class Checkout

    attr_accessor :rule, :basket

    def initialize(rules)
        f = File.new(rules)
        i=0
        @rule=Array.new
        @basket=Hash.new
        while line = f.gets
          if line[0] != "#"
            rule[i]=line.split(" ")
            rule[i][1]= rule[i][1].sub("+"," ")  # Remove "+" in product name
            basket[rule[i][0]] = 0
            i += 1
          end
        end
        f.close
    end

    def total
        total=0     # Total with discounts
        etotal=0    # Total without discounts

        basket.each do |prod_id,count|
            rule.each do |r|
                next if r[0] != prod_id
                price=r[2].to_f
                discount=r[3].to_f
                items=r[4].to_i
                x41=r[5].to_i
                etotal = etotal + count * price

                if x41 <  2 then   # Therefore maybe a discount
                    if discount == 0.0 || count<items  then
                        total += count*price
                    else
                        total = total + count*(price-discount)
                    end
                else
                    total = total + (count/x41)*price + count%x41
                end
            end
        end
        puts "Original total: $#{etotal}"
        return total
    end

    def validate(item)
        rule.each do |x|
            return true if x[0] == item
        end
        puts "Item #{item} does not exist"
        return false
    end

    def scan(item)
        basket[item] += 1 if validate(item)
    end

end

pricing_rules = "rules.text"

# Basket: FR1, AP1, FR1, CF1
# Total price expected: $22.25   actual=19.34 orig=22.45
puts "\nCustomer Sam"
Sam = Checkout.new(pricing_rules)
Sam.scan("FR1")   # 3.11
Sam.scan("AP1")   # 5
Sam.scan("FR1")   # 3.11
Sam.scan("CF1")   # 11.23
price = Sam.total
puts "Actual total: $#{price}"

# Basket: FR1, FR1
# Total price expected: $3.11   (6.22)
puts "\nCustomer Tom"
Tom = Checkout.new(pricing_rules)
Tom.scan("FR1")   # 3.11
Tom.scan("FR1")   # 3.11
price = Tom.total
puts "Actual total: $#{price}"

# Basket: AP1, AP1, FR1, AP1
# Total price expected: $16.61
puts "\nCustomer Ann"
Ann = Checkout.new(pricing_rules)
Ann.scan("AP1")   # 5
Ann.scan("AP1")   # 5
Ann.scan("FR1")   # 3.11
Ann.scan("CF1")   # 11.23
price = Ann.total
puts "Actual total: $#{price}"
puts "Fini."
