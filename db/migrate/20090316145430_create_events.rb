class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      #事件状态(0指未安排)
      t.integer :state, :limit => 2, :null => false, :default => 0
      #事件时间
      t.datetime :timing, :null => false
      #主题(规则:姓名__目的__值班室)
      t.string :title, :null => false, :limit => 20
      #内容摘要
      t.string :content, :null => false, :limit => 800
      #事件类型:来电,来访等(Rails自动设置)
      t.string :type, :null => false, :limit => 10
      #(来电)目的,紧急程度,保密程度,事件分类
      t.integer :aim, :emergency, :security, :kind, :limit => 2

      #姓名,联系电话,手机号码,Email
      t.string :name, :phone, :mobile, :limit => 20
      #性别
      t.integer :sex, :limit => 2
      #联系地址
      t.string :address, :email, :limit => 50

      #call attribute
      #来电号码, 来电编号
      t.string :callnumber, :calltag, :null => false, :limit => 20

      #创建人,修改人
      t.integer :creator_id, :modifier_id, :null => false

      #关联case
      t.references :case, :nill => false

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
