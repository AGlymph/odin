require_relative '../lib/caesar'


describe CaesarCipher do

  describe '#encrypt'
    context 'when translating one word' do 
      subject(:one_word) {described_class.new('Odin')}

      it 'works with small positive shift' do
        small_shift = 5
        small_result = one_word.encrypt(small_shift)
        expect(small_result).to eql('Tins')
      end

      it 'works with small negative shift' do
        small_negative_shift = -5
        small_negative_result = one_word.encrypt(small_negative_shift)
        expect(small_negative_result).to eql('Jydi')
      end

      it 'works with large positive shift' do
        large_shift = 74
        large_result = one_word.encrypt(large_shift)
        expect(large_result).to eql('Kzej')
      end

      it 'works with large negative shift' do
        large_negative_shift = -55
        large_negative_result = one_word.encrypt(large_negative_shift)
        expect(large_negative_result).to eql('Lafk')
      end
    context 'when translating a phrase with punctuation' do
      subject(:punctuation_phrase) { described_class.new('Hello, World!') }

      it 'works with small positive shift' do
        small_shift = 9
        small_result = punctuation_phrase.encrypt(small_shift)
        expect(small_result).to eq('Qnuux, Fxaum!')
      end

      it 'works with small negative shift' do
        small_negative_shift = -5
        small_negative_result = punctuation_phrase.encrypt(small_negative_shift)
        expect(small_negative_result).to eql('Czggj, Rjmgy!')
      end

      it 'works with large positive shift' do
        large_shift = 74
        large_result = punctuation_phrase.encrypt(large_shift)
        expect(large_result).to eql('Dahhk, Sknhz!')
      end

      it 'works with large negative shift' do
        large_negative_shift = -55
        large_negative_result = punctuation_phrase.encrypt(large_negative_shift)
        expect(large_negative_result).to eql('Ebiil, Tloia!')
      end
    end
    end
  end