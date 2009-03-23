假如 /我刚新增来电/ do
  call = Call.create!(
    :callnumber => 13988889999,
    :calltag => "深电2009032300045",
    :title => "马可波罗__投诉__区长热线办公室",
    :name => "马可波罗",
    :callnumber => "13988889999",
    :timing => "2009-03-23 10:10:10".to_time,
    :creator => "aaron",
    :modifier => "aaron"
  )
  visit edit_call_path(call)
end
