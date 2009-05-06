class Conversation < ActiveRecord::Base
  has_many :events, :order => :id
  has_many :people, :through => :event
  #事件分类
  belongs_to :kind
  #待办事项
  has_many :workitems
  #处理过程
  has_many :historys
  #创建人,修改人
  belongs_to :creator, :class_name => "User"
  belongs_to :modifier, :class_name => "User"

  validates_presence_of :title, :content
  validates_length_of :title, :maximum => 20, :allow_nil => true
  validates_length_of :content, :maximum => 800, :allow_nil => true

  define_index do
    indexes [
      events.person.phone,
      events.person.mobile
    ], :as => :phone
  end

  #当前流程ID
  attr_accessor :workitem_id

  before_create do |c|
    c.tag = Sequence.case_tag
  end

  #状态矩阵,key为当前事件的状态,value hash中的key为办理方式,value为下一个状态值
  @@matrix = {
    #未安排
    0 => {
      #转办(待处理),自己受理(已受理),直接办结(已办结)
      10 => 10,
      20 => 20,
      90 => 90
    },
    #待处理
    10 => {
      #转办(待处理),受理(已受理),申请办结(待审核),退回(已退回)
      10 => 10,
      21 => 20,
      30 => 30,
      40 => 40
    },
    #已受理
    20 => {
      #转办(待处理),申请办结(待审核)
      10 => 10,
      30 => 30
    },
    #已退回
    40 => {
      #转办(待处理),受理(已受理)
      10 => 10,
      21 => 20
    },
    #待重办
    50 => {
      #转办(待处理),受理(已受理),申请办结(待审核)
      10 => 10,
      21 => 20,
      30 => 30
    },
    #待审核
    30 => {
      #确认办结(已办结),退回重办(待重办)
      91 => 90,
      41 =>50
    }
  }

  #根据办理方式(handle)及当前事件状态,得出事件的下一状态
  def set_next_state_from(handle)
    self.state = @@matrix[self.state][handle]
  end

  #根据当前事件状态,判断流程处理页面应显示的办理方式
  def handles
    @@matrix[self.state].keys
  end
end
