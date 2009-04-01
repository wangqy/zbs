class CreateWorkitems < ActiveRecord::Migration
  def self.up
    create_table :workitems do |t|
      #任务所属的user.login或department.code
      t.string :store_name, :null => false
      t.references :event, :null => false
      #办理人
      t.string :creator, :null => false
      #上一个任务的store_name,[退回,退回重办]时使用
      t.string :last_store_name

      t.timestamps
    end
  end

  def self.down
    drop_table :workitems
  end
end
