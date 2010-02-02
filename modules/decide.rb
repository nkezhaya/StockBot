def decide(*args)
  yes, no = 0, 0
  rand(10_000).times do
    if rand(2) == 1
      yes += 1
    else
      no  += 1
    end
  end

  say_to_chan "#{args.flatten.join(' ')} | Votes: #{yes + no} | Yes: #{yes} | No: #{no}"
end
