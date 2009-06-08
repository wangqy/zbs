而且 /有以下公告数据/ do |notices|

end

当 /^我删除第(\d+)个公告$/ do |pos|
  within("tbody > tr:nth-child(#{pos})") do
    click_link "删除"
  end
end

当 /我修改第(\d+)个公告的(.+)为(.+)/ do |pos,label,value|
  within("tbody > tr:nth-child(#{pos})") do
    click_link '编辑'
  end
  当 "我输入#{label}为#{value}"
  而且 "我点击保存"
end

当 /我查看第(\d+)个公告/ do |pos|
  within("tbody > tr:nth-child(#{pos})") do
    click_link "查看"
  end
end
