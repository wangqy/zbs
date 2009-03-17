class Call < Event

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
