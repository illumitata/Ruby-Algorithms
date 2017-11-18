require_relative '../lib/prime'

describe PrimeGenerator do
  describe '#initialize(limit)' do
    it 'given argument is a number' do
      expect { PrimeGenerator.new('test') }.to raise_error(ArgumentError)
      expect { PrimeGenerator.new('100') }.to raise_error(ArgumentError)
      expect { PrimeGenerator.new(4) }.not_to raise_error
      expect { PrimeGenerator.new(100) }.not_to raise_error
    end
  end

  describe '#eratostenesSieve' do
    it 'return array without not prime numbers' do
      expect(PrimeGenerator.new(4).eratosthenesSieve).not_to include(4)
      expect(PrimeGenerator.new(10).eratosthenesSieve).not_to include(4, 6, 8, 9)
      expect(PrimeGenerator.new(20).eratosthenesSieve).not_to include(4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20)
    end

    it 'return primes between 2 and limit' do
      expect(PrimeGenerator.new(3).eratosthenesSieve).to match_array([2, 3])
      expect(PrimeGenerator.new(10).eratosthenesSieve).to match_array([2, 3, 5, 7])
      expect(PrimeGenerator.new(30).eratosthenesSieve).to match_array([2, 3, 5, 7, 11, 13, 17, 19, 23, 29])
    end
  end
end
