set :environment, 'development'
set :output, {:error => "log/cron_error.log", :standard => "log/cron.log"}

every 1.minute do
  rake 'sms:send', :output => {:error => "log/cron_error.log", :standard => "log/cron.log"}
end

# every 1.day, :at => '6.26 pm' do
#   rake 'sms:smart'
# end