def decide(*args)
  votes, yes = 10_000, 0
  votes.times { yes += 1 if rand(2) == 1 }
  result = (votes - yes > (votes / 2)) ? 'Yes' : 'No'
  sender = args[0].pop

  say_to_chan "#{args.flatten.join(' ')} | Result: #{result}"
end
