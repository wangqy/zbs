class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      
      t.string :realname
      t.integer :sex
      t.integer :department_id
      t.string :position
      t.string :telephone, :limit=>20
      t.string :mobile, :limit=>20
      t.integer :ismanager
      t.string :email, :limit=>120
      t.string :remark, :limit=>20

      t.integer :creator
      t.integer :modifier

      t.timestamps
    end

    say 'create admin user'
    User.create!({:login => 'admin', :password => 'admin', :realname => '管理员', :telephone => '26741022'})
    
  end

  def self.down
    drop_table "users"
  end
end
