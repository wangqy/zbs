假如 /我在(.*)页面/ do |page|
  url = ""
  case page
  when "登录"
    url = "/"
  when "用户新增" 
    url = new_user_path
  end
  visit url
end

当 /我输入(.*)为(.*)/ do |label, value|
  fill_in(label, :with => value)
end

而且 /我点击(.*)/ do |label|
  click_button('save')
end

那么 /我应该能看到:(.*)/ do |text|
  response.should contain(text)
end

假如 /我已经以管理员(.*)身份登录/ do |login|
  假如 "我在登录页面"
  当 "我输入用户名为#{login}"
  当 "我输入密码为admin"
  而且 "我点击登录"
end

