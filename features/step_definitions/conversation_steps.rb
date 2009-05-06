当 /我输入事件的其他信息/ do
  而且 "我选中来电"
  而且 "我选择目的为投诉"
  而且 "我选择紧急程度为一般"
  而且 "我选择保密程度为一般"
  而且 "我输入主题为马海波咨询新劳动法法规"
  而且 "我输入内容摘要为咨询人对法规存在误解"
  而且 "我选择事件分类为普通事务"
  而且 "我选择性别为男"
  而且 "我输入联系电话为0755-26741022"
  而且 "我输入电子邮箱为mahb@cogentsoft.com.cn"
  而且 "我输入手机号码为13928452841"
  而且 "我输入联系地址为深圳南山科技园"
  而且 "我输入工作单位为高正公司"
end

而且 /我应该能看到子事件:/ do |hashes|
  hashes.raw.each_with_index do |row, pos|
    response.should have_selector(".conversation_info > ul > li:nth-child(#{pos+1})") do |li|
      text = li.inner_text.gsub(/\n/,'').squeeze.strip
      text.should contain(row.join(' '))
    end
  end
end
