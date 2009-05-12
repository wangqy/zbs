class CreateWorkitems < ActiveRecord::Migration
  def self.up
    create_table :workitems do |t|
      #任务所属的user.id
      t.integer :store_id, :null => false
      t.references :conversation, :null => false
      #办理人
      t.string :creator, :null => false
      #上一个任务的store_id,[退回,退回重办]时使用
      t.integer :last_store_id

      t.timestamps
    end
  end

  def self.down
    drop_table :workitems
  end
end
