def karma(*args)
  key = args.flatten.first
  return unless key =~ /([\w\d\_\-]+)(\+\+|\-\-)/i

  key       = $1
  operation = $2[0].chr
  karma     = DB[:karma].filter(:key => key).first

  if karma
    score = (karma[:score] || 0).send(operation, 1)
    DB[:karma].filter(:id => karma[:id]).update(:score => score)
  else
    score = 0.send(operation, 1)
    DB[:karma].insert(:key => key, :score => score)
  end

  say_to_chan "Score for #{key} updated to #{score}."
end
