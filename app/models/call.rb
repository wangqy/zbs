class Call < Event
  validates_presence_of :callnumber, :on => :save

  define_index do
    indexes content
    set_property :delta => true
  end

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
