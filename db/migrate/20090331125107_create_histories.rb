class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.references :conversation
      #办理方式
      t.integer :handle
      #转办部门,截止日期,相关负责人
      t.references :department
      t.date :timeout
      t.references :user
      #办理意见,备注
      t.string :reason
      t.string :remark
      #创建人
      t.references :creator, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :histories
  end
end
