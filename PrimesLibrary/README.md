# Little Ruby library for primality tests
###### by illumitata
[![Build Status](https://travis-ci.org/my-rspec/hello-rspec-illumitata.svg?branch=master)](https://travis-ci.org/my-rspec/hello-rspec-illumitata)

| Professor | Student | Album number |
|:---------:|:-------:|:------------:|
| [dr Włodzimierz Bzyl](https://github.com/wbzyl) | [Jan Iwaszkiewicz](https://github.com/illumitata) | 238215 | |

## Why primality test?
What is a primality test? According to [Wikipedia](https://en.wikipedia.org/wiki/Primality_test):
> A primality test is an algorithm for determining whether an input number is prime.

Ok... but why we have to find this type of things?
Here is a list of things that heavily relise on those numbers:
* Cryptography
* Security systems
* Coding TV signals
* Hash codes
* Life of cicadas (very interesting topic)
* and list goes on...

## Rspec
To run rspec test for PrimesLibrary, just type in command line:
```
rspec
```
**Make sure you are in PrimesLibrary folder!**

## Algorithms

### Testing primality
To test the primality of given number I choose to implement three algorithms:

#### Naive Method
Given an input number *n*. Check whether any prime integer *m* from **2 to √n** evenly divides *n* (the division leaves no remainder). If *n* is divisible by any *m* then *n* is composite, otherwise it is prime.

#### Fermat Primality Test
Given an integer *n*, choose some integer a coprime to *n* and calculate **a^(n−1) modulo n**.
<br />If the result is different from 1, then *n* is composite. If it is 1, then *n* may be prime.

There is a small problem. Some composite numbers (called **Carmichael numbers**) have the property that:
<br />**a^(n−1) is 1 (modulo n)** for every *a* that is coprime to *n*.
<br />**Therefore the method should not be used to determining the primality of a number when the correctness of the result is crucial. In example in cryptography.**

#### Miller-Rabin Primality Test
Given an integer *n*, choose some positive integer *a < n*. Let **2^s * d = n − 1**, where *d* is odd. If:
<br />*a^d =/= 1 (modulo n)*
<br />and
<br />*a^((2^r) * d) =/= -1 (modulo n)* for all 0 <= r <= s-1,
<br />then *n* is composite and a is a witness for the compositeness. Otherwise, *n* may or may not be prime.
<br />**The Miller–Rabin test is a strong pseudoprime test.**

### Generating prime numbers
There is also a class for generating these numbers. Used algorithms:

#### Eratosthenes Sieve
Simple, ancient algorithm for finding all prime numbers up to any given limit.
<br />The main idea here is that every value given to *p* will be prime, because if it were composite it would be marked as a multiple of some other, smaller prime.
<br />**Note that some of the numbers may be marked more than once (e.g., 15 will be marked both for 3 and 5).**
<br />**Given that information, we can call this method fully functional, but very slow in computing time meaning.**
