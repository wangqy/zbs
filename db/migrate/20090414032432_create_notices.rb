class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      #标题 内容 是否发布
      t.string :title, :limit => 120
      t.string :content, :limit => 800
      t.integer :deployed
      t.references :creator
      t.references :modifier
      #发布人 发布时间
      t.references :deployee
      t.datetime :deployed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :notices
  end
end
