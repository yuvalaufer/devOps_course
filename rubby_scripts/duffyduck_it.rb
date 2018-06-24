# starting script

  print "Pleathe enter a thtring: " 
  user_input = gets.chomp
until user_input.length != 0
  print "Pleathe enter a thtring: " 
  user_input = gets.chomp
end
  user_input.downcase!
if user_input.include? "s"
  user_input.gsub!(/s/,"th")
  puts "your new string is: #{user_input}"
elsif (user_input.include? "ce") || (user_input.include? "ci") || (user_input.include? "cy")
  user_input.gsub!(/c/,"th")
  puts "your new string is: #{user_input}"
else
  print "there is no s in your string"
end

#end of script
