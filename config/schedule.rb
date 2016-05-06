# set :environment, 'development'
set :output, {:error => "log/cron_error.log", :standard => "log/cron.log"}

every 1.minutes do
  rake 'sms:send'
end

# every 1.day, :at => '6.26 pm' do
#   rake 'sms:smart'
# end