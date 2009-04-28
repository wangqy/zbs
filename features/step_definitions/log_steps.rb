而且 /有以下日志数据/ do |log|

end

当 /我查看第(\d+)条日志/ do |pos|
  within("table >tr:nth-child(#{pos.to_i+1})") do
    click_link "查看"
  end
end
