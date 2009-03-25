假如 /我刚新增来电/ do
  call = Call.create!(
    :callnumber => "13988889999",
    :timing => "2009-03-23 10:10:10".to_datetime,
    :calltag => "深电2009032300045",
    :title => "马可波罗__投诉__区长热线办公室",
    :content => "楼下太吵了",
    :name => "马可波罗",
    :creator => "aaron",
    :modifier => "aaron"
  )
  visit edit_call_path(call)
end

当 /我输入(.*)的来电信息/ do |callnumber|
  当 "我输入来电电话为#{callnumber}"
  而且 "我输入来电时间为2009-03-24 22:22" 
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

而且 /我在第(\d+)条记录中点击(.*)按钮/ do |pos, button_label|
  within("table >tr:nth-child(#{pos.to_i+1})") do
    click_link button_label
  end
end
