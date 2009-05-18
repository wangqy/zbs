class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      #事件时间
      t.datetime :timing, :null => false
      #内容摘要
      t.string :content, :limit => 800
      #事件类型(来电,来访,来函,传真等)
      t.integer :category, :null => false, :limit => 2
      #关联录音记录
      t.references :record
      #创建人,修改人
      t.references :creator, :modifier, :null => false
      #关联大事件
      t.references :conversation, :null => false
      #关联联系人
      t.references :person, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
