class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      #姓名
      t.string :name
      #联系电话
      t.string :phone
      #手机号码
      t.string :mobile
      #性别
      t.integer :sex
      #Email
      t.string :email
      #联系地址
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
