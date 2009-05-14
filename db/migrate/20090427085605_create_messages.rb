class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.references :conversation, :null => false
      t.references :user, :null => false
      t.string :content, :null => false
      t.integer :creator_id, :null => false
      #是否已经向短信机发送
      t.boolean :is_sended, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
