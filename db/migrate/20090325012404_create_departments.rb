class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      #名称
      t.string :name, :limit=>40
      #负责人
      t.string :manager, :limit=>10
      #联系电话
      t.string :telephone, :limit=>20
      #传真
      t.string :fax, :limit=>20
      #地址
      t.string :address, :limit=>120
      #备注
      t.string :remark, :limit=>800
      #创建人
      t.references :creator
      #最后修改人
      t.references :modifier
      #上级机构
      t.integer :parent_id
      #值班室信息:职能,线路
      t.string :responsibility, :limit=>120
      t.integer :lines, :limit=>4

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
