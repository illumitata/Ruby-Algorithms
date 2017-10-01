#################################################
###     Szukanie przybliżenia pierwiastka     ###
###                  w Ruby                   ###
###       Jan Iwaszkiewicz @illumitata        ###
#################################################

class NRoot
  attr_accessor :root

  def getInput
    print("\nPodaj liczbę, której pierwiastka szukasz: ")
    @inputNumber = gets.to_f

    print("\nPodaj stopień pierwiastka: ")
    @rootDegree = gets.to_f
  end

  def calcRoot
    if @rootDegree < 0
      puts("Pierwiastek nie istnieje!")
    else
      precision  = 0.00000001 #precyzja z jaką obliczamy pierwiastek
      $result = @inputNumber/@rootDegree

      begin
#       puts("#{$result}")
        delta = (1/@rootDegree) * ((@inputNumber/($result**(@rootDegree-1))) - $result)
        $result = $result + delta
      end until delta.abs < precision
    end
  end

end

  if __FILE__ == $0

    findRoot = NRoot.new

    findRoot.getInput
    findRoot.calcRoot
    puts("\nWynik to: #{$result.round(6)}")

  end
