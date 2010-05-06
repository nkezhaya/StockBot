require 'config'

task :install do
  DB.create_table(:karma) do
    primary_key :id
    String :key
    Fixnum :score
  end

  DB.create_table(:users) do
    primary_key :id
    String :name
    String :weather
    String :sms_email
  end
end
