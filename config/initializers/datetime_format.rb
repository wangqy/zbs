ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :without_year => "%m-%d %H:%M",
  :with_year => "%Y-%m-%d %H:%M",
  :only_date => "%m-%d",
  :full => "%Y-%m-%d %H:%M:%S",
  :short => "%Y-%m-%d"
)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :serial => "%Y%m%d"
)
