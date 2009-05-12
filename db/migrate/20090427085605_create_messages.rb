class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.references :conversation, :null => false
      t.references :user, :null => false
      t.string :content, :null => false
      t.integer :creator_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
