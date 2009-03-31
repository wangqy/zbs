而且 /有以下人员数据/ do |employees|
  employees = employees.arguments_replaced({"姓名"=>"name","性别"=>"sex","办公电话"=>"telephone","手机"=>"mobile","地址"=>"address","部门"=>"department_id"}).hashes
  p employees
  list = employees.each do |e|
    @department = Department.find_by_name(e["department_id"])
    e["department_id"] = @department.id
    if e["sex"] == "男"
      e["sex"] = 1;
    else
      e["sex"] = 2;
    end
  end
  
  p list
                                           
  Employee.create!(list)
end

当 /我输入人员信息/ do
  当 "我输入姓名为张三"
  而且 "我选中男"
  而且 "我选择部门为劳动局"
  而且 "我输入职位为科员"
  而且 "我输入办公电话为26742222"
  而且 "我输入手机为13688888888"
  而且 "我输入电子邮箱为zhangsan@zhangsan.com"
  而且 "我输入备注为备注"
end


当 /我修改第(\d+)个人员的(.+)为(.+)/ do |pos,label,value|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '编辑'
  end
    当 "我输入#{label}为#{value}"
    而且 "我点击保存"
end

当 /我查看第(\d+)个人员/ do |pos|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link "查看"
  end
end

当 /我删除第(\d+)个人员/ do |pos|
  within("table.list > tr:nth-child(#{pos.to_i+1})") do
    click_link '删除'
  end
end
