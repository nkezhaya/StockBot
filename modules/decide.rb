def decide(*args)
  sender = args[0].pop
  options = args.flatten.sort_by { rand }

  result = options[Random.number(options.length) - 1]
  say_to_chan "#{result}"
end
