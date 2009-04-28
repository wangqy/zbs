而且 /(.+)的(.+)立即收到短信通知/ do |dept_name, realname|
  user = User.find_by_realname(realname)
  Message.last.user.should == user
end
