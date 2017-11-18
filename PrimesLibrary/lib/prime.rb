# Module for testing passed arguments
module ArgumentTest
  def checkIfString(argument)
    raise ArgumentError, 'Argument can not be a string or float' if (argument.is_a? Integer) == false
  end

  def checkIfGreater(number, limit)
    raise ArgumentError, "Argument must be a positive integer greater than #{limit}" if number <= limit
  end

  def checkIfMore(argument)
    raise ArgumentError, 'Argument must be a positive integer greater than 2' if argument <= 2
  end
end

# Class for testing primality of given number
class PrimeTest
  include ArgumentTest

  def initialize(number)
    checkIfString(number)
    checkIfGreater(number, 1)
    @number = number
  end

  def self.moduloPower(n, e, m)
    return 'wrong e' if e < 0
    result = 1
    base = n % m
    until e.zero?
      result = (result * base) % m if e.odd?
      e >>= 1
      base = (base * base) % m
    end
    result
  end

  def naiveTest
    return true if @number == 2
    return false if @number.even?
    g = Math.sqrt(@number).round
    i = 3
    while i <= g
      return false if (@number % i).zero?
      i += 2
    end
    true
  end

  def fermatTest(k)
    checkIfString(k)
    checkIfGreater(k, 0)

    return true if @number == 2 || @number == 3

    k.times do
      a = rand(2..@number - 2)
      num = PrimeTest.moduloPower(a, @number - 1, @number)
      return false if num != 1
    end
    true
  end

  def millerRabinTest(base)
    checkIfString(base)
    return false if @number.even? && @number != 2
    return true if @number == 2

    s = 0
    d = @number - 1
    while d.even?
      d /= 2
      s += 1
    end
    base.times do
      a = rand(1..@number - 1)
      num = PrimeTest.moduloPower(a, d, @number)
      next if num == 1 || num == @number - 1
      (1..s - 1).each do
        num = PrimeTest.moduloPower(num, 2, @number)
        return false if num == 1
        break if num == @number - 1
      end
      return false if num != @number - 1
    end
    true
  end
end

# Class for generating prime numbers in given range
class PrimeGenerator
  include ArgumentTest

  def initialize(limit)
    checkIfString(limit)
    checkIfMore(limit)
    @limit = limit
  end

  def eratosthenesSieve
    primes = Array.new(@limit + 1, 1)
    primes[0] = primes[1] = 0

    (2..Math.sqrt(@limit)).each do |sieve|
      next unless primes[sieve] == 1
      (2 * sieve).step(@limit, sieve).each do |i|
        primes[i] = 0
      end
    end

    (2..@limit).select { |i| primes[i] == 1 }
  end
end
