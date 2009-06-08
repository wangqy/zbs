假如 /我在(.*)页面/ do |page|
  url = ""
  case page
  when "登录"
    url = "/"
  when "用户管理" 
    url = users_path
  when "用户新增"
    url = new_user_path
  when "受理事件" 
    url = conversations_path
  when "事件调度" 
    url = dispatches_path
  when "事件记录" 
    url = searches_path
  when "待办事项" 
    url = workitems_path
  when "机构管理"
    url = departments_path
  when "公告管理"
    url = notices_path
  when "公告新增"
    url = new_notice_path
  when "日志管理"
    url = logs_path
  when "事件分类新增"
    url = new_kind_path
  when "往来记录新增"
    url = new_reply_path
  when "录音记录"
    url = records_path
  when "添加往来记录"
    url = events_path
  end
  raise 'visit url is blank' if url.blank?
  visit url
end

而且 /我进入(.*)链接/ do |label|
  click_link(label)
end

当 /我输入(.*)为(.*)/ do |label, value|
  fill_in(label, :with => value)
end

当 /我选择(.*)为(.*)/ do |label, value|
  select(value, :from => label)
end

当 /我选中(.*)/ do |field|
  choose(field)
end

当 /我勾选(.*)/ do |field|
  check(field)
end

当 /我勾去(.*)/ do |field|
  uncheck(field)
end

而且 /我点击(.*)/ do |label|
  click_button(label)
end

而且 /我单击按钮(.*)/ do |label|
  if %w(登录 保存).include?(label)
    label = :save
  elsif %w(查询).include?(label)
    label = :search
  end
  click_button(label)
end

而且 /我触发链接(.*)/ do |label|
  click_link(label)
end

而且 /我在第(\d+)条记录中点击(.*)按钮/ do |pos, button_label|
  within("tbody >tr:nth-child(#{pos})") do
    click_link button_label
  end
end

那么 /我应该能看到(.*)输入的值:(.*)/ do |label, text|
  response.body.should =~ /#{text}/m
end

那么 /我应该看不到输入的值:(.*)/ do |text|
  response.body.should_not =~ /#{text}/m
end

那么 /我应该能看到:(.*)/ do |text|
  response.should contain(text)
end

那么 /我应该能看到连续的内容:(.*)/ do |text|
  text.split.each do |t|
    response.should contain(t)
  end
end

那么 /浏览器后台返回:(.*)/ do |text|
  encoded_text = ActiveSupport::JSON.encode(text);
  response.should contain(encoded_text[1,encoded_text.size-2]);
end

那么 /我应该看不到:(.*)/ do |text|
  response.should_not contain(text)
end

那么 /(.*)变为(.*)/ do |label, value|
  field_labeled(label).value.should == value
end

#使用fixture初始化数据,不要实现方法体
假如 /有以下数据/ do |hashes|
end

那么 /我将看到以下数据/ do |hashes|
  hashes.rows.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("tbody > tr:nth-child(#{i+1}) > td:nth-child(#{j+1})") do |td|
        td.inner_text.should == cell
      end
    end
  end
end

那么 /我应该能在页脚看到:(.+)/ do |text|
  visit '/home/foot'
  response.should contain(text)
end
