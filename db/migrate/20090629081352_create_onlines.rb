class CreateOnlines < ActiveRecord::Migration
  def self.up
    create_table :onlines, :options => "ENGINE=memory" do |t|
      #用户id
      t.integer :user_id
      t.datetime :actived_at
    end
  end

  def self.down
    drop_table :onlines
  end
end
