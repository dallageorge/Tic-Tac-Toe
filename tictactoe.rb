class Player
  @win
 
  def setname
    puts "Please enter your name:"
    x= gets.strip
    @name=x
  end
  
  def getname
    return @name
  end
  
  def setsymbol
    puts "Please enter your marking symbol:"
    x= gets 
    @symbol = x[0]
  end

  def checkincludes(inp)
    if @symarray.include?(inp)
      return true
  
    else return false
    end
  end

  
  def getsymbol
    return @symbol
  end
  
  def symarrayappend(inp)
    @symarray.append(inp)
    
  end
  
  def checkwinner?
    winc1 =@symarray.include?([0,0]) && @symarray.include?([1,1]) && @symarray.include?([2,2])
    winc2=@symarray.include?([0,0]) && @symarray.include?([0,1]) && @symarray.include?([0,2])
    winc3 =@symarray.include?([1,0]) && @symarray.include?([1,1]) && @symarray.include?([1,2])
    winc4 =@symarray.include?([2,0]) && @symarray.include?([2,1]) && @symarray.include?([2,2])
    winc5 =@symarray.include?([0,3]) && @symarray.include?([1,2]) && @symarray.include?([2,1])
    return winc1 || winc2 || winc3 || winc4 || winc5
  end

  
  private
  @name
  @symbol
  def initialize
    @symarray = []
  end

end






def userinput(player)
  puts player.getname() +", it's your turn."
  loop do
  puts "Enter a row number (0-2):"
  x = gets.to_i
  puts "Enter a column (0-2):"
  y= gets.to_i
   if !(x>2 || y>2) &&  determine_symbol([x,y]) == " "
     player.symarrayappend([x,y])
     break
   else 
     puts "Wrong Input, try again"
   end
  end

end




def determine_symbol(arrayinp)
  if $p1.checkincludes(arrayinp)
    return $p1.getsymbol
  elsif $p2.checkincludes(arrayinp)
    return $p2.getsymbol
  else return " "
  end
end

def print_current_board()
  puts "\n \n"
  for i in [0,1,2]
    for j in [0,1]
      print determine_symbol([i,j]) + "|" 
    end
    print determine_symbol([i,2])
    if(i!=2)
      puts "\n- - - "
    end
  end
  puts "\n \n"
end

def playgame()
  moves=0
  loop do
    userinput($p1)
    print_current_board()
    moves = moves +1
    break if ($p1.checkwinner? || $p2.checkwinner? || moves==9)
    userinput($p2)
    print_current_board()
    moves = moves +1
    break if ($p1.checkwinner? || $p2.checkwinner? || moves==9)
  
  end
  if $p1.checkwinner?
    puts $p1.getname+" won the game!!" 
  elsif $p2.checkwinner?
    puts $p2.getname+" won the game!!" 
  else
    puts "It's a draw!"
  end
end





puts "Player one:"
$p1 = Player.new
$p1.setname()
$p1.setsymbol()
puts "Player two:"
$p2 = Player.new
loop do
  $p2.setname()
  if $p2.getname != $p1.getname
    break
  else puts "Name is already tacken, try another one."
  end
end
loop do
  $p2.setsymbol()
  if $p2.getsymbol != $p1.getsymbol
    break
  else puts "Symbol is already tacken, try another one."
  end
end

playgame()