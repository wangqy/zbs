假如 /我在(.*)页面/ do |page|
  url = ""
  case page
  when "登录"
    url = "/"
  when "用户管理" 
    url = new_user_path
  when "来电管理" 
    url = new_call_path
  when "机构管理"
    url = departments_path
  when "机构新增"
    url = new_department_path
  end
  visit url
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

假如 /有以下用户数据/ do |users|
  #users = users.arguments_replaced({"用户名"=>"login","姓名"=>"realname"})
  #User.create!(users.hashes)
end
  
当 /我修改第(\d+)个用户的(.+)为(.+)/ do |pos, label, value|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '编辑'
  end
  当 "我输入#{label}为#{value}"
  而且 "我点击确定"
end
