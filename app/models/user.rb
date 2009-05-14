require 'digest/sha1'
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  belongs_to :department
  has_many :workitems, :foreign_key => "store_id"

  validates_presence_of     :login, :realname, :telephone, :mobile, :department_id, :role
  validates_uniqueness_of   :login, :case_sensitive => false
  validates_length_of       :realname, :maximum => 10
  validates_length_of       :telephone,:maximum => 20
  validates_length_of       :email,    :maximum => 120, :allow_nil => true
  validates_length_of       :remark,   :maximum => 800, :allow_nil => true
  validates_length_of       :password, :maximum => 40, :allow_nil => true
  validates_length_of       :site, :maximum => 10, :allow_nil => true
  validates_length_of       :login,    :maximum => 40
  before_save :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  # =========== 新加字段时注意要修改此处 ============
  attr_accessible :login, :password, :realname, :telephone, :mobile, :position, :ismanager, :sex, :remark, :fax, :department_id, :email, :modifier, :disabled, :role, :site

  def validate_on_create
    if password.blank?
      errors.add(:password, '不能为空')
    end
  end

  def validate_on_update
    #puts "pp=#{password==nil}"
    if password == "" 
      errors.add(:password, '不能为空')
    end
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{login}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def is_admin?
    self.role == 1
  end

  def is_digit_person?
    self.role == 2
  end

  def is_dispatch_person?
    self.role == 3
  end

  def is_depart_person?
    self.role == 4
  end

  protected
    # before filter 
    def encrypt_password
      return if password.nil?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    
end
