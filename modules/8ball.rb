Object.send(:define_method, '8ball'.to_sym) do |*args|
  possible_answers = [
    'As I see it, yes.',
    'It is certain.',
    'It is decidedly so.',
    'Most likely.',
    'Outlook good.',
    'Signs point to yes.',
    'Without a doubt.',
    'Yes.',
    'Yes - definitely.',
    'You may rely on it.',

    'Reply hazy, try again.',
    'Ask again later.',
    'Better not tell you now.',
    'Cannot predict now.',
    'Concentrate and ask again.',

    'Don\'t count on it.',
    'My reply is no.',
    'My sources say no.',
    'Outlook not so good.',
    'Very doubtful.',
    'nawwwwwwwwwwwwww'
  ]

  result = possible_answers[Random.number(possible_answers.length) - 1]
  sender = args[0].pop

  say_to_chan "#{sender}: #{result}"
end
