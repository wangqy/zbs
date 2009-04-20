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

而且 /我触发链接(.*)/ do |label|
  click_link(label)
end

而且 /我在第(\d+)条记录中点击(.*)按钮/ do |pos, button_label|
  within("table >tr:nth-child(#{pos.to_i+1})") do
    click_link button_label
  end
end

那么 /我应该能看到输入的值:(.*)/ do |text|
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
      response.should have_selector("table.list > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") do |td|
        td.inner_text.should == cell
      end
    end
  end
end
