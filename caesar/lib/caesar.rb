class CaesarCipher
  def initialize (message)
    @message = message
  end

  def encrypt(shift = 0)
    shifted_string_array = @message.chars.map do |c|
      if c.ord.between?(65, 90)
        ((c.ord - 65 + shift) % 26 + 65).chr
      elsif c.ord.between?(97, 122)
        ((c.ord - 97 + shift) % 26 + 97).chr
      else
        c
      end
  end
    shifted_string_array.join
  end

end


# cipher = CaesarCipher.new('What a string!')
# p cipher.encrypt(5)
# "Bmfy f xywnsl!"