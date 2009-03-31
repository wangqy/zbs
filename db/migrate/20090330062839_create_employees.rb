class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      #姓名 性别 部门 办公电话 手机 是否负责人 备注 创建人 最后修改人
      t.string :name, :limit=>10
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
  end

  def self.down
    drop_table :employees
  end
end
