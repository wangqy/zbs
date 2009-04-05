class Call < Event
  validates_presence_of :callnumber, :on => :save

  named_scope :history_of, lambda{|call|
    sql = "callnumber = ?"
    conditions = [sql, call.callnumber]
    unless call.new_record?
      sql << " and id != ?"
      conditions << call.id
    end
    {:conditions => conditions}
  }

end
