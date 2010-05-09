def decide(*args)
  sender = args[0].pop

  options = if args.join.include? ','
              args.flatten.join(' ').split(',').sort_by { rand }
            else
              args.flatten.sort_by { rand }
            end

  result = options[Random.number(options.length) - 1]
  say_to_chan "#{result.strip}"
end
