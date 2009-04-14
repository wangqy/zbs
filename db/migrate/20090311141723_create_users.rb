class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      
      #姓名
      t.string :realname, :null => false
      #性别
      t.integer :sex
      #部门
      t.integer :department_id, :null => false
      #角色
      t.integer :role, :null => false
      #职位
      t.string :position
      #办公电话
      t.string :telephone, :limit=>20
      #手机
      t.string :mobile, :limit=>20
      #是否负责人
      t.integer :ismanager
      #电子邮箱
      t.string :email, :limit=>120
      #备注
      t.string :remark, :limit=>20
      #是否禁用
      t.integer :disabled

      t.integer :creator
      t.integer :modifier

      t.timestamps
    end

    say 'create admin user'
    User.create!({:login => 'admin', :password => 'admin', :realname => '管理员', :telephone => '26741022', :department_id => 0, :disabled => 0, :role => 1})
    
  end

  def self.down
    drop_table "users"
  end
end
