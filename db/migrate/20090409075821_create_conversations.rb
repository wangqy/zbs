class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      #事件状态(0指未安排)
      t.integer :state, :limit => 2, :null => false, :default => 0
      #编号,主题
      t.string :tag, :title, :null => false, :limit => 20
      #目的,紧急程度,保密程度
      t.integer :aim, :emergency, :security, :limit => 2
      #事件分类
      t.integer :kind_id
      #内容摘要
      t.string :content, :null => false, :limit => 800
      #截止日期
      t.date :finish_at, :null => false
      #创建人,修改人
      t.integer :creator_id, :modifier_id, :null => false
      #增量索引标记
      t.boolean :delta, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :conversations
  end
end
