class CreateCases < ActiveRecord::Migration
  def self.up
    create_table :cases do |t|
      #内容摘要
      t.string :content
      #(来电)目的,紧急程度,保密程度,事件分类
      t.integer :aim
      t.integer :emergency
      t.integer :security
      t.integer :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :cases
  end
end
