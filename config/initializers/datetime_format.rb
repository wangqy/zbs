ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :without_year => "%m-%d %H:%M",
  :with_year => "%Y-%m-%d %H:%M",
  :only_date => "%m-%d",
  :full => "%Y-%m-%d %H:%M:%S",
  :short => "%Y-%m-%d",
  #用于组合出录音文件的名称
  :wav_file_date => "%Y%m%d-%H%M%S"
)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :serial => "%Y%m%d"
)
