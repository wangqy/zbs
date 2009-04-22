class Log < ActiveRecord::Base 
  belongs_to :operator, :class_name => "User" 

  validates_presence_of :operate, :modulename, :objectid, :ip, :operatedate
  validates_length_of :modulename, :maximum => 10 
  validates_length_of :content, :maximum => 120, :allow_nil => true
  validates_length_of :ip, :maximum => 15

  #新增
  def self.create(object, user, ip, content=nil)
    log(object.class.name, 1, object.id, user, ip, content)
  end

  #修改
  def self.update(object, user, ip, content=nil)
    log(object.class.name, 2, object.id, user, ip, content)
  end
  
  #删除
  def self.delete(object, user, ip, content=nil)
    log(object.class.name, 3, object.id, user, ip, content)
  end
  
  #禁用
  def self.disable(object, user, ip, content=nil)
    log(object.class.name, 4, object.id, user, ip, content)
  end

  #启用
  def self.enable(object, user, ip, content=nil)
    log(object.class.name, 5, object.id, user, ip, content)
  end

  #修改密码
  def self.pass(object, user, ip, content=nil)
    log(object.class.name, 6, object.id, user, ip, content)
  end

  #修改坐席号
  def self.site(object, user, ip, content=nil)
    log(object.class.name, 61, object.id, user, ip, content)
  end
  
  #登录
  def self.login(user, ip, content=nil)
    log(user.class.name, 7, user.id, user, ip, content)
  end

  #退出
  def self.logout(user, ip, content=nil)
    unless user.nil?
      log(user.class.name, 8, user.id, user, ip, content)
    end
  end
  
  #记录用户操作日志
  #@modulename  模型名称
  #@operate     操作类型
  #@objectid    操作对象ID
  #@user        操作用户
  #@ip          IP
  #@content     操作内容
  def self.log(modulename, operate, objectid, user, ip, content=nil)
    hash = {:modulename=>modulename,
            :operate=>operate,
            :objectid=>objectid,
            :ip=>ip,
            :content=>content,
            :operatedate=>Time.now,
            :operator=>user
            }
    log = self.new(hash)
    log.save
  end
end
