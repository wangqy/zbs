class Enum
  #来电目的
  AIM = [
    %w{求助 投诉 咨询 建议 举报 其他},
    %w{1    2    3    4    5    9   }
  ]

  #生成相应的方法
  #如调用aim,返回整个Hash
  #如调用aim(1),则返回对应的值"求助"
  self.constants.each do |c| 
    class_eval <<-EOF                                                                                                                                        
      p "init enum: #{c}"
      #用于取值{1 => "求助", 2 => "投诉"}
      #{c}_HASH = {}
      #用于返回如[["求助", 1], ["投诉", 2]]
      #{c}_ARRAY = []
      #{c}[0].each_index do |i|
        #{c}_HASH[#{c}[1][i].to_i] = #{c}[0][i]
        #{c}_ARRAY << [#{c}[0][i], #{c}[1][i]]
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

end
