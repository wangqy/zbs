class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.integer :kind, :limit => 2, :null => false
      #拨打电话,接收电话
      t.string :dail, :receive, :limit => 15, :null => false
      #呼叫中心录音唯一标识符,用于关联录音文件
      t.string :wavfile, :limit => 32, :null => false

      t.datetime :created_at, :null => false
    end
  end

  def self.down
    drop_table :records
  end
end
