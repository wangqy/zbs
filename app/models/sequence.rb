class Sequence < ActiveRecord::Base
  def self.get
    s = self.find_by_day(Date.today)
    if s
      s.increment! :number
    else
      s = self.create(:day => Date.today)
    end
    s.number
  end

  def self.case_tag
    "深#{Date.today.to_s(:serial)}#{self.get.to_s.rjust(5,'0')}"
  end
end
