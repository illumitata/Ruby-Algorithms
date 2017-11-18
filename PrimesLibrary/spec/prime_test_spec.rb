require_relative '../lib/prime'

describe PrimeTest do
  describe '#initialize(number)' do
    it 'given argument is the positive integer greater than 1' do
      err_str = 'Argument must be a positive integer greater than 1'
      expect { PrimeTest.new(1) }.to raise_error(ArgumentError, err_str)
      expect(PrimeTest.new(3).instance_variable_get(:@number)).to be > 1
      expect(PrimeTest.new(99_031).instance_variable_get(:@number)).to be > 1
      expect { PrimeTest.new(0) }.to raise_error(ArgumentError, err_str)
      expect { PrimeTest.new(-1) }.to raise_error(ArgumentError, err_str)
      expect { PrimeTest.new(-9999) }.to raise_error(ArgumentError, err_str)
    end

    it 'given argument is an integer' do
      err_str = 'Argument can not be a string or float'
      expect { PrimeTest.new(2) }.not_to raise_error
      expect { PrimeTest.new(529_528_952) }.not_to raise_error
      expect { PrimeTest.new('test') }.to raise_error(ArgumentError, err_str)
      expect { PrimeTest.new('100') }.to raise_error(ArgumentError, err_str)
      expect { PrimeTest.new(0.001) }.to raise_error(ArgumentError, err_str)
      expect { PrimeTest.new(100) }.not_to raise_error
    end
  end

  describe '.moduloPower' do
    it 'wrong e exepection' do
      err_str = 'wrong e'
      expect(PrimeTest.moduloPower(10, -1, 10)).to eq(err_str)
      expect(PrimeTest.moduloPower(8, -3, -3)).to eq(err_str)
      expect(PrimeTest.moduloPower(1630, -100_898, -100)).to eq(err_str)
      expect(PrimeTest.moduloPower(8, 4, 41)).not_to eq(err_str)
      expect(PrimeTest.moduloPower(1567, 49_242, 568)).not_to eq(err_str)
    end
  end

  describe '#naiveTest' do
    it 'return true for number 2' do
      expect(PrimeTest.new(2).naiveTest).to eq true
      expect(PrimeTest.new(2).naiveTest).not_to eq false
    end

    it 'return true for other primes' do
      expect(PrimeTest.new(5).naiveTest).to eq true
      expect(PrimeTest.new(11).naiveTest).to eq true
      expect(PrimeTest.new(7919).naiveTest).to eq true
      expect(PrimeTest.new(393_919).naiveTest).to eq true
      expect(PrimeTest.new(999_999_000_001).naiveTest).to eq true
      expect(PrimeTest.new(4_393_139).naiveTest).not_to eq false
    end

    it 'return false for not prime number' do
      # obvious not prime numbers
      expect(PrimeTest.new(4).naiveTest).not_to eq true
      expect(PrimeTest.new(100).naiveTest).not_to eq true
      expect(PrimeTest.new(393_918).naiveTest).not_to eq true
      expect(PrimeTest.new(393_918_000_022_222).naiveTest).to eq false

      # some of the Carmichael numbers to test
      expect(PrimeTest.new(561).naiveTest).to eq false
      expect(PrimeTest.new(8911).naiveTest).to eq false
      expect(PrimeTest.new(825_265).naiveTest).to eq false
    end
  end

  describe '#fermatTest(k)' do
    it 'raise error if k is not a number not greater than 0' do
      expect { PrimeTest.new(88).fermatTest('duża dokładność') }.to raise_error(ArgumentError)
      expect { PrimeTest.new(100).fermatTest('0') }.to raise_error(ArgumentError)
      expect { PrimeTest.new(10).fermatTest(-10) }.to raise_error(ArgumentError)
      expect { PrimeTest.new(10).fermatTest(0) }.to raise_error(ArgumentError)
      expect { PrimeTest.new(920).fermatTest }.to raise_error(ArgumentError)
      expect { PrimeTest.new(100).fermatTest(PrimeTest.new(20)) }.to raise_error(ArgumentError)
    end

    it 'do not raise error if k is a number greater than 0' do
      expect { PrimeTest.new(10).fermatTest(1) }.not_to raise_error
      expect { PrimeTest.new(9000).fermatTest(4) }.not_to raise_error
      expect { PrimeTest.new(9000).fermatTest(10) }.not_to raise_error
      expect { PrimeTest.new(90).fermatTest(999) }.not_to raise_error
    end

    it 'return true for number 2' do
      expect(PrimeTest.new(2).fermatTest(1)).to eq true
      expect(PrimeTest.new(2).fermatTest(10)).not_to eq false
    end

    it 'return true for other primes' do
      expect(PrimeTest.new(5).fermatTest(10)).to eq true
      expect(PrimeTest.new(11).fermatTest(10)).to eq true
      expect(PrimeTest.new(7919).fermatTest(1000)).to eq true
      expect(PrimeTest.new(393_919).fermatTest(1000)).to eq true
      expect(PrimeTest.new(999_999_000_001).fermatTest(1000)).to eq true
      expect(PrimeTest.new(4_393_139).fermatTest(1000)).not_to eq false
    end

    it 'return false for not prime number' do
      # obvious not prime numbers
      expect(PrimeTest.new(4).fermatTest(3)).not_to eq true
      expect(PrimeTest.new(100).fermatTest(10)).not_to eq true
      expect(PrimeTest.new(393_918).fermatTest(1000)).not_to eq true
      expect(PrimeTest.new(393_918_000_022_222).fermatTest(10_000)).to eq false
    end

    it "return not true to special case Carmichael's number" do
      expect(PrimeTest.new(561).fermatTest(100)).not_to eq true
      expect(PrimeTest.new(8911).fermatTest(100)).not_to eq true
      expect(PrimeTest.new(825_265).fermatTest(10_000)).not_to eq true
    end
  end

  describe '#millerRabinTest(base)' do
    it 'raise error if base is not a number' do
      expect { PrimeTest.new(88).millerRabinTest('mała dokładność dokładność') }.to raise_error(ArgumentError)
      expect { PrimeTest.new(100).millerRabinTest('0') }.to raise_error(ArgumentError)
      expect { PrimeTest.new(88).millerRabinTest }.to raise_error(ArgumentError)
      expect { PrimeTest.new(100).millerRabinTest('100484') }.to raise_error(ArgumentError)
      expect { PrimeTest.new(100).millerRabinTest(PrimeTest.new(100)) }.to raise_error(ArgumentError)
    end

    it 'do not raise error if base is a number' do
      expect { PrimeTest.new(100).millerRabinTest(1) }.not_to raise_error
      expect { PrimeTest.new(100).millerRabinTest(100) }.not_to raise_error
      expect { PrimeTest.new(100).millerRabinTest(890_002) }.not_to raise_error
    end

    it 'return true for number 2' do
      expect(PrimeTest.new(2).millerRabinTest(10)).to eq true
      expect(PrimeTest.new(2).millerRabinTest(2)).not_to eq false
    end

    it 'return true for other primes' do
      expect(PrimeTest.new(5).millerRabinTest(2)).to eq true
      expect(PrimeTest.new(11).millerRabinTest(4)).to eq true
      expect(PrimeTest.new(7919).millerRabinTest(100)).to eq true
      expect(PrimeTest.new(393_919).millerRabinTest(123)).to eq true
      expect(PrimeTest.new(999_999_000_001).millerRabinTest(1000)).to eq true
      expect(PrimeTest.new(4_393_139).millerRabinTest(300)).not_to eq false
    end

    it 'return false for not prime number' do
      # obvious not prime numbers
      expect(PrimeTest.new(4).millerRabinTest(3)).not_to eq true
      expect(PrimeTest.new(100).millerRabinTest(10)).not_to eq true
      expect(PrimeTest.new(393_918).millerRabinTest(1000)).not_to eq true
      expect(PrimeTest.new(393_918_000_022_222).millerRabinTest(1000)).to eq false

      # some of the Carmichael numbers to test
      expect(PrimeTest.new(561).millerRabinTest(100)).to eq false
      expect(PrimeTest.new(8911).millerRabinTest(100)).to eq false
      expect(PrimeTest.new(825_265).millerRabinTest(1000)).to eq false
    end
  end
end
