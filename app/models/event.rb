class Event < ActiveRecord::Base
  belongs_to :conversation
  #联系人
  belongs_to :person
  #值班室信息
  has_one :duty
  #创建人,修改人
  belongs_to :creator, :class_name => "User"
  belongs_to :modifier, :class_name => "User"

  validates_presence_of :category, :timing
  validates_length_of :content, :maximum => 800, :allow_nil => true

  def init_case(case_id)
    unless case_id.blank?
      self.case = Conversation.find(case_id)
    else
      self.build_case(
        :callnumber => self.callnumber,
        :phone => self.phone,
        :mobile => self.mobile,
        :content => self.content
      )
    end
  end

end
