DB[:users].each do |user|
  user[:name].gsub! /\W+/, ''
  Object.send(:define_method, user[:name].to_sym) do
    say_to_chan user[:picture]
  end
end
