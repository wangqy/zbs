class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      #姓名
      t.string :name, :limit => 20, :null => false
      #联系电话,手机号码,身份证号码
      t.string :phone, :mobile, :cardno, :limit => 20
      #性别
      t.integer :sex, :limit => 2
      #联系地址,工作单位,Email
      t.string :address, :jobunit, :email, :limit => 50
      #创建人,修改人
      t.integer :creator_id, :modifier_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
