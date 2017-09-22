#################################################
### Implementacja sortowania kopcowego w Ruby ###
###       Jan Iwaszkiewicz @illumitata        ###
#################################################

#!/usr/bin/env ruby

#Kopiec
class HeapSort
  attr_accessor :heap

  #Zainicjowanie tablicy
  def initialize(heap = [4, 2, 1, 3, 10, 7, 5])
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
    spaceNum = (@heap.length + 1)
    k = 2

    (1..(@heap.length)).each do |i|
      (1..spaceNum-1).each do
        print " "
      end

      print @heap[i-1]

      (1..spaceNum).each do
        print " "
      end

      if i + 1 == k
        k += k
        spaceNum /= 2
        print "\n"
      end
    end
    print"\n\n"
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

    print "\nYour heap:\n"
    sort.drawHeap

    sort.sorting

    print "\nSorted array:\n"
    puts sort.heap.join(" ")

    print("\n")

  end
