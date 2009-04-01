class Employee < ActiveRecord::Base
  belongs_to :department

  validates_presence_of :name, :department_id, :telephone
  validates_length_of :name, :maximum => 10
  validates_length_of :telephone, :position, :mobile, :maximum => 20
  validates_length_of :email, :maximum => 120
  validates_length_of :remark, :maximum => 800


  def sexText
    if sex==1
      "男"
    else
      "女"
    end
  end
end
