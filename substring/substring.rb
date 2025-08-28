def substrings(phrase, dictionary)
  phrase_array = phrase.downcase.split(' ')
  dictionary.reduce(Hash.new(0)) do |counts, string| 
    phrase_array.each do |word|
      if word.include?(string)
        counts[string] += 1
      end
    end
    counts
  end
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)