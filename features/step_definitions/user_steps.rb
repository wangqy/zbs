假如 /有以下用户数据/ do |hashes|
  User.delete_all
  users = hashes.arguments_replaced({"用户名"=>"login","姓名"=>"realname"}).hashes
  users.each do |user|
    user[:department_id] = Department.last.id
    user[:telephone] = '26741022'
    user[:mobile] = '13988889999'
    user[:password] = 'test'
    user[:password] = 'admin' if user["login"] == "cogentsoft"
    user[:disabled] = 1 if user["login"] == "disable"
    User.create! user
  end
end

假如 /我已经以用户(.*),密码(.*)登录/ do |login, password|
  假如 "我在登录页面"
  当 "我输入用户名为#{login}"
  当 "我输入密　码为#{password}"
  而且 "我单击按钮登录"
end

假如 /我已经以用户(.*)身份登录/ do |login|
  假如 "我已经以用户#{login},密码test登录"
end

假如 /我已经以管理员(.*)身份登录/ do |login|
  假如 "我已经以用户#{login},密码admin登录"
end
  
当 /我修改第(\d+)个用户的(.+)为(.+)/ do |pos, label, value|
  within("tbody > tr:nth-child(#{pos})") do
    click_link '编辑'
  end
  当 "我输入#{label}为#{value}"
  而且 "我点击保存"
end

当 /我禁用第(\d+)个用户/ do |pos|
  within("tbody > tr:nth-child(#{pos})") do
    click_link '禁用'
  end
end

当 /我启用第(\d+)个用户/ do |pos|
  within("tbody > tr:nth-child(#{pos})") do
    click_link '启用'
  end
end

当 /我触发页脚链接(.+)/ do |text|
  visit '/home/foot'
  click_link(text)
end
