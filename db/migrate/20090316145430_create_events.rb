class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      #事件时间
      t.datetime :timing, :null => false
      #内容摘要
      t.string :content, :limit => 800
      #事件类型(来电,来访,来函,传真等)
      t.integer :category, :null => false, :limit => 2
      #呼叫中心录音唯一标识符,用于关联录音文件
      t.string :wavfile, :limit => 32
      #创建人,修改人
      t.integer :creator_id, :modifier_id, :null => false
      #关联大事件
      t.references :conversation, :nill => false
      #关联联系人
      t.references :person, :nill => false
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
