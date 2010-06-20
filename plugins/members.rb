module Plugins
  DB[:users].each do |user|
    user[:name].gsub! /\W+/, ''
    define_method user[:name].to_sym do
      say_to_chan user[:picture]
    end
  end
end
