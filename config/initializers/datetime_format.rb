ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :without_year => "%m-%d %H:%M",
  :with_year => "%Y-%m-%d %H:%M",
  :only_date => "%m-%d"
)
