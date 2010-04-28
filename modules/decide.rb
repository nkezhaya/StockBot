def decide(*args)
  sender = args[0].pop

  say_to_chan "#{args.flatten.sort_by { rand }.first}"
end
