class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      #机构编码
      t.string :code, :limit=>10
      #名称
      t.string :name, :limit=>40
      #负责人
      t.string :manager, :limit=>10
      #联系电话
      t.string :telephone, :limit=>20
      #传真
      t.string :fax, :limit=>20
      #电子邮件
      t.string :email, :limit=>50
      #地址
      t.string :address, :limit=>120
      #备注
      t.string :remark, :limit=>800
      #创建人
      t.integer :creator
      #最后修改人
      t.integer :modifier

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
