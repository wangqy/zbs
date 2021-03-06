# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :cron_log, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.day, :at => '1:00 am' do
  #更新thinking-sphinx的增量索引
  rake 'ts:index'
end

#每天发送待办事项短信
every :weekday, :at => '10:00 am' do
  runner "Workitem.send_msg"
end

#定时发送转办短信
every 10.minutes do
  runner "Message.send_msg"
end
