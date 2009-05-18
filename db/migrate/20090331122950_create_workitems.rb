class CreateWorkitems < ActiveRecord::Migration
  def self.up
    create_table :workitems do |t|
      #任务所属的user.id
      t.integer :store_id, :null => false
      t.references :conversation, :null => false
      #办理人
      t.references :creator, :null => false

      #上一个任务的store_id,即上一操作人,[退回,退回重办]时使用
      t.integer :last_store_id, :null => false

      t.datetime :created_at, :null => false
    end
  end

  def self.down
    drop_table :workitems
  end
end
