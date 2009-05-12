假如 /有以下用户数据/ do |hashes|
  User.delete_all
  users = hashes.arguments_replaced({"用户名"=>"login","姓名"=>"realname"}).hashes
  users.each do |user|
    user[:department_id] = Department.last.id
    user[:role] = 1
    user[:role] = 2 if user["login"] == "disable" || user["login"] == "quentin"
    user[:telephone] = '26741022'
    user[:password] = 'test'
    user[:password] = 'admin' if user["login"] == "cogentsoft"
    user[:disabled] = 1 if user["login"] == "disable"
    User.create! user
  end
end

假如 /我已经以用户(.*),密码(.*)登录/ do |login, password|
  假如 "我在登录页面"
  当 "我输入用户名为#{login}"
  当 "我输入密码为#{password}"
  而且 "我点击登录"
end

假如 /我已经以用户(.*)身份登录/ do |login|
  假如 "我已经以用户#{login},密码test登录"
end

假如 /我已经以管理员(.*)身份登录/ do |login|
  假如 "我已经以用户#{login},密码admin登录"
end
  
当 /我修改第(\d+)个用户的(.+)为(.+)/ do |pos, label, value|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '编辑'
  end
  当 "我输入#{label}为#{value}"
  而且 "我点击保存,返回列表"
end

当 /我禁用第(\d+)个用户/ do |pos|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '禁用'
  end
end

当 /我启用第(\d+)个用户/ do |pos|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '启用'
  end
end
