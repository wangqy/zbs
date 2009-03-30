class Enum
  #try aen to get snippet

  #流程状态
  STATE = [
    %w{转办 受理 申请办结 退回 直接办结}, 
    %w{1    2    3        4    9       }
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

end
