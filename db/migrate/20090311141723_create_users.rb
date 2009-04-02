class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      
      t.string :realname

      t.references :department
      t.timestamps
    end

    say 'create admin user'
    User.create!({:login => 'admin', :password => 'admin'})
  end

  def self.down
    drop_table "users"
  end
end
