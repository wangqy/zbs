class Event < ActiveRecord::Base
  belongs_to :conversation
  #联系人
  belongs_to :person
  #用户(回电或回访时使用)
  belongs_to :user
  #值班室信息
  has_one :duty
  #创建人,修改人
  belongs_to :creator, :class_name => "User"
  belongs_to :modifier, :class_name => "User"

  validates_presence_of :category, :timing
  validates_length_of :content, :maximum => 800, :allow_nil => true

  def is_in?
    self.category < 20
  end

  def is_out?
    self.category >= 20
  end
end
