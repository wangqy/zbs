class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      #事件时间
      t.datetime :timing
      #主题(规则:姓名__目的__值班室)
      t.string :title
      #内容摘要
      t.string :content
      #事件类型:来电,来访等(Rails自动设置)
      t.string :type
      #(来电)目的,紧急程度,保密程度,事件分类
      t.integer :aim
      t.integer :emergency
      t.integer :security
      t.integer :kind

      #来电号码call attribute
      t.string :phone
      
      t.references :person
      t.references :case

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
