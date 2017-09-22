#################################################
### Implementacja sortowania kopcowego w Ruby ###
###       Jan Iwaszkiewicz @illumitata        ###
#################################################

#!/usr/bin/env ruby

#Kopiec
class HeapSort
  attr_accessor :heap

  #Zainicjowanie tablicy
  def initialize(heap = [4, 3, 2, 33, 11, 6, 5, 9, 88, 99, 22, 31, 11, 3, 4])
    @heap = heap
  end

  #Operacja przywracania warunku kopca
  def heapify(num)
    left  = num * 2
    right = num * 2 + 1

    if left <= @heapSize && @heap[left] > @heap[num]
      largest = left
    else
      largest = num
    end

    if right <= @heapSize && @heap[right] > @heap[largest]
      largest = right
    end

    if(largest != num)
      tmp = @heap[num]
      @heap[num] = @heap[largest]
      @heap[largest] = tmp
      heapify(largest)
    end
  end

  #Tworzenie kopca
  def buildHeap
    @heapSize = @heap.length - 1

    ((@heap.length-1)/2).downto(0).each do |i|
      heapify(i)
    end
  end

  #Rozbieranie kopca
  def sorting
    ((@heap.length-1)).downto(0).each do |i|
      tmp = @heap[0]
      @heap[0] = @heap[i]
      heap[i] = tmp
      @heapSize -= 1
      heapify(0)
    end
  end

  #Wizualizacja kopca
  def drawHeap
    tmpSize = @heap.length
    k = 1
    levelsNum = 1

    while tmpSize > 0 do
      tmpSize = tmpSize - k
      k += k * 2
      levelsNum += 1
    end

    puts "heap level: #{levelsNum}"

    spaceNum = 1

    (1..levelsNum+1).each do |j|
      spaceNum += j * 2
    end

    spaceNum += levelsNum
    k = 2

    (1..(@heap.length)).each do |i|
      (1..spaceNum).each do
        print " "
      end

      print @heap[i-1]

      (1..spaceNum).each do
        print " "
      end

      if i + 1 == k
        k = k * 2
        spaceNum /= 2
        print("\n")
      end
    end
  end

end

  #Program
  if __FILE__ == $0

    sort = HeapSort.new

    puts "\nArray to sort:"
    puts sort.heap.join(" ")

# => również wypisanie całej tablicy
#    puts sort.heap[0..(sort.heap.length-1)]

    sort.buildHeap

    print "\nAfter building a heap:\n"
    puts sort.heap.join(" ")

    print "\nYour heap --- "
    sort.drawHeap

    sort.sorting

    print "\nSorted array:\n"
    puts sort.heap.join(" ")

    print("\n")

  end
