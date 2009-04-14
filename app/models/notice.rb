class Notice < ActiveRecord::Base

  #创建人
  belongs_to :creator, :class_name => "User"
  #最后修改人
  belongs_to :modifier, :class_name => "User"
  #发布人
  belongs_to :deployee, :class_name => "User"

  validates_presence_of :title, :content
  validates_length_of :title, :maximum => 120
  validates_length_of :content, :maximum => 800
end
