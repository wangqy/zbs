class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      #操作类型(1 新增,2 修改, 3 删除, 4 禁用, 5 启用, 6 修改密码, 7 登录, 8 退出)
      t.integer :operate
      t.string :modulename, :limit => 10
      t.string :content, :limit => 120
      t.integer :objectid
      t.datetime :operatedate
      t.string :ip, :limit => 15
      t.references :operator

      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
