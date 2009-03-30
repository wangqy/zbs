而且 /有以下机构数据/ do |departments|
  departments = departments.arguments_replaced({"机构编码前缀"=>"code_prefix","机构编码后缀"=>"code_suffix","机构名称"=>"name","负责人"=>"manager","联系电话"=>"telephone","地址"=>"address"})
  Department.create!(departments.hashes)
end

当 /我修改第(\d+)个机构的(.+)为(.+)/ do |pos,label,value|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '编辑'
  end
    当 "我输入#{label}为#{value}"
    而且 "我点击保存"
end

当 /我查看第(\d+)个机构/ do |pos|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link "查看"
  end
end

当 /我删除第(\d+)个机构/ do |pos|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '删除'
  end
end
