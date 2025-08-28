require_relative 'lists.rb'


class HashMap
  attr_accessor :bucket_array, :buckets
  def initialize (load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity)
  end

  def get_bucket(key, capacity = @capacity)
    hash_code = hash(key)
    index = hash_code % capacity
    raise IndexError if index.negative? || index >= capacity
    return index
  end

  def hash(key)
   hash_code = 0
   prime_number = 31
      
   key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
      
   hash_code
  end

  def grow_buckets(rate=2)
    puts "growing capacity"
    new_capacity = @capacity*rate
    new_buckets = Array.new(new_capacity)
    entries.each do |entry|
      index = get_bucket(entry[0], new_capacity)
      new_buckets[index] = HashLinkedList.new() if new_buckets[index].nil? 
      new_buckets[index].append(entry[0],entry[1])
    end

    @buckets = new_buckets
    @capacity = new_capacity
  end

  def set(key,value)
    grow_buckets if length >= @capacity * @load_factor 
    index = get_bucket(key)
    @buckets[index] = HashLinkedList.new() if @buckets[index].nil? 
    remove(key) if has?(key)
    @buckets[index].append(key,value)
  end

  def get(key)
    index = get_bucket(key)
    return nil if !@buckets[index]
    @buckets[index].find_value(key)
  end

  def has?(key)
    get(key) ? true : false
  end

  def remove(key)
    index = get_bucket(key)
    return nil if !@buckets[index]
    @buckets[index].remove(key)
  end

  def length
    @buckets.reduce(0) { |total_length, bucket| total_length + (bucket.nil? ? 0 : bucket.length)}
  end

  def clear
    @buckets.map! { |bucket| bucket = nil}
  end

  def keys 
    @buckets.reduce(Array.new()) do  |keys, bucket| 
      unless bucket.nil? 
        keys += bucket.keys 
      end
      keys
    end
  end

  def values
    @buckets.reduce(Array.new()) do  |values, bucket| 
      unless bucket.nil? 
        values += bucket.values 
      end
      values
    end
  end

  def entries
    @buckets.reduce(Array.new()) do  |entries, bucket| 
      unless bucket.nil? 
        entries += bucket.entries 
      end
      entries
    end
  end
  
  def to_s 
    @buckets.each {|bucket| puts bucket unless bucket.nil?}
  end

end

test = HashMap.new
test.set('apple', 'red')
 test.set('banana', 'yellow')
 test.set('carrot', 'orange')
 test.set('dog', 'brown')
 test.set('elephant', 'gray')
 test.set('frog', 'green')
 test.set('grape', 'purple')
 test.set('hat', 'black')
 test.set('ice cream', 'white')
 test.set('jacket', 'blue')
 test.set('kite', 'pink')
 test.set('lion', 'golden')


puts test
 test.set('moon', 'silver')

puts test
