class Call < Event
  validates_presence_of :callnumber, :on => :save
  validates_presence_of :timing, :on => :save

  named_scope :history_of, lambda{|call|
    sql = "callnumber = ?"
    conditions = [sql, call.callnumber]
    unless call.new_record?
      sql << " and id != ?"
      conditions << call.id
    end
    {:conditions => conditions}
  }

  def before_create
    unless self.case
      create_case(
        :content => content,
        :aim => aim,
        :emergency => emergency,
        :security => security,
        :kind => kind
      )
    end
    unless self.person
      create_person(
        :name => name,
        :phone => phone,
        :mobile => mobile,
        :sex => sex,
        :email => email,
        :address => address
      )
    end
  end

end
