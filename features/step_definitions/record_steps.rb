而且 /(\d+)来电,系统弹出新的窗口/ do |phone|
  visit "/pop/dail_in/#{phone}/802/wavfile"
end

而且 /去电(\d+),系统弹出新的窗口/ do |phone|
  visit "/pop/dail_out/802/#{phone}/wavfile"
end
