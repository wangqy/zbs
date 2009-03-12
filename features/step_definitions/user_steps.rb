假如 /我在登录页面/ do
  visit "/"
end

当 /我输入(.*)为(.*)/ do |label, value|
  fill_in(label, :with => value)
end

而且 /我点击登录/ do
  click_button('save')
end

那么 /我应该能看到:(.*)/ do |text|
  response.should contain(text)
end
