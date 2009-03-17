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
  end

end
