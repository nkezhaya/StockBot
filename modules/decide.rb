def decide(*args)
  votes = 10_000
  require 'ruby-debug/debugger'
  yes = 0
  votes.times { yes += 1 if rand(2) == 1 }
  result = (votes - yes > (votes / 2)) ? 'Yes' : 'No'

  say_to_chan "#{args.flatten.join(' ')} | Result: #{result}"
end