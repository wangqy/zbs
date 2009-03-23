假如 /我刚新增来电/ do
  call = Call.create!(:callnumber=>13988889999)
  visit edit_call_path(call)
end
