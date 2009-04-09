def create_call(options)
  @valid_attributes = {
    :calltag => "深电2009032300088",
    :timing => DateTime.now.to_s(:with_year),
    :title => "马可波罗__投诉__区长热线办公室",
    :content => "楼下太吵了",
    :name => "马可波罗",
    :creator => User.find_by_login("aaron"),
    :modifier => User.find_by_login("aaron"),
    :case => Case.first
  }
  @valid_attributes.merge! options
  Call.create! @valid_attributes
end

当 /系统弹出(\d+)的来电录入窗口/ do |callnumber|
  #以往来电
  create_call :callnumber => callnumber
  visit(new_call_path(:callnumber => callnumber))
end

假如 /我新增(\d+)的来电/ do |callnumber|
  call = create_call(:callnumber => callnumber)
  visit edit_call_path(call)
end

当 /我输入(.*)的来电信息/ do |callnumber|
  当 "我输入来电电话为#{callnumber}"
  而且 "我输入#{callnumber}来电的其他信息"
end

当 /我输入(.*)来电的其他信息/ do |callnumber|
  而且 "我输入来电人姓名为马可波罗"
  而且 "我选择来电目的为投诉"
  而且 "我选择紧急程度为一般"
  而且 "我选择保密程度为一般"
  而且 "我输入来电主题为马可波罗__投诉__区长热线办公室"
  而且 "我输入内容摘要为来电反映楼下大排档晚上营业非常吵1112"
  而且 "我选择事件分类为普通事务"
  而且 "我选择性别为男"
  而且 "我输入联系电话为0755-26741022"
  而且 "我输入电子邮箱为mahb@cogentsoft.com.cn"
  而且 "我输入手机号码为#{callnumber}"
  而且 "我输入联系地址或单位为简洁公司"
end
