假如 /我在(.*)页面/ do |page|
  url = ""
  case page
  when "登录"
    url = "/"
  when "用户管理" 
    url = new_user_path
  when "新增来电" 
    url = new_call_path
  end
  visit url
end

当 /我输入(.*)为(.*)/ do |label, value|
  fill_in(label, :with => value)
end

当 /我选择(.*)为(.*)/ do |label, value|
  select(value, :from => label)
end

而且 /我点击(.*)/ do |label|
  button_id = "save"
  case label
  when "确定"
    button_id = "edit"
  end
  click_button(button_id)
end

那么 /我应该能看到:(.*)/ do |text|
  response.should contain(text)
end

那么 /我应该看不到:(.*)/ do |text|
  response.should_not contain(text)
end

那么 /(.*)变为(.*)/ do |label, value|
  field_labeled(label).value.should == value
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

那么 /我将看到以下用户数据/ do |users|
  users.rows.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table.list > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") do |td|
        td.inner_text.should == cell
      end
    end
  end
end
