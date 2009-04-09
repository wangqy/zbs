class Enum
  #try aen to get snippet

  #办理方式
  HANDLE = [
    %w{转办 自己受理 受理 申请办结 退回 退回重办 直接办结 确认办结}, 
    %w{10   20       21   30       40   41       90       91      }
  ]
  
  #流程状态
  STATE = [
    %w{未安排 待处理 已受理 待审核 已退回 待重办 已办结}, 
    %w{0      10     20     30     40     50     90    }
  ]

  #来电目的
  AIM = [
    %w{求助 投诉 咨询 建议 举报 其他},
    %w{1    2    3    4    5    9   }
  ]

  #紧急程度
  EMERGENCY = [
    %w{一般 紧急 十万火急}, 
    %w{1    2    3       }
  ]

  #保密程序
  SECURITY = [
    %w{一般 一级保密 二级保密 三级保密 高级保密}, 
    %w{1    2        3        4        5       }
  ]

  #事件分类
  KIND = [
    %w{普通事务 投诉 }, 
    %w{1        2    }
  ]

  #性别
  SEX = [
    %w{男 女 }, 
    %w{1  2  }
  ]
  
  #是否
  SF = [
    %w{是 否 }, 
    %w{1  0  }
  ]

  #生成相应的方法
  #如调用aim,返回整个Hash
  #如调用aim(1),则返回对应的值"求助"
  self.constants.each do |c| 
    class_eval <<-EOF                                                                                                                                        
      #用于取值{1 => "求助", 2 => "投诉"}
      #{c}_HASH = {}
      #用于返回如[["求助", 1], ["投诉", 2]]
      #{c}_ARRAY = []
      #{c}[0].each_index do |i|
        #{c}_HASH[#{c}[1][i].to_i] = #{c}[0][i]
        #{c}_ARRAY << [#{c}[0][i], #{c}[1][i].to_i]
      end
      def self.#{c.downcase}(value=nil)
        if value
          #{c}_HASH[value]
        else
          #{c}_ARRAY
        end
      end
    EOF
  end 

  module EnumViewer
    @@regexp = /(.+)_enum(_(.+))*/

    def method_missing(method, *args)
      unless method.to_s =~ @@regexp
        return super
      end

      m = @@regexp.match(method.to_s)
      property = m[1]
      value = self.send(property)
      return unless value

      enum_code = m[3]
      enum_code = property unless enum_code
      Enum.send(enum_code, value)
    end

    #修正通过关联关系得到的实体对象无法调用_enum方法的问题
    def respond_to?(method_sym, include_private = false)
      if method_sym.to_s =~ /_enum/
        true
      else
        super
      end
    end
  end

  ActiveRecord::Base.send :include, EnumViewer
end

#重载rails的select方法,增加对枚举的支持
class ActionView::Helpers::FormBuilder
  alias_method :orig_select, :select 
  undef :select

  def select(method, choices = nil, options = {}, html_options = {})
    unless choices
      choices = Enum.__send__(method) 
    end
    orig_select(method, choices, options, html_options)
  end

  #生成枚举单选按钮
  def radio_enum(method, enum=nil, options = {}, html_options = {})
    enums = enum.nil? ?Enum.__send__(method):Enum.__send__(enum)
    html = ""
    enums.each do |v|
      html += radio_button method, v[1]
      html += label "#{method}_#{v[1]}", v[0]
    end
    html
  end

end
