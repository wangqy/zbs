class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.references :event
      #办理方式
      t.integer :handle
      #转办部门,截止日期,相关负责人
      t.string :department_code
      t.date :timeout
      t.string :responser
      #办理意见,备注
      t.string :reason
      t.string :remark
      #办理人
      t.string :creator

      t.timestamps
    end
  end

  def self.down
    drop_table :histories
  end
end
