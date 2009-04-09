class CreateCases < ActiveRecord::Migration
  def self.up
    create_table :cases do |t|
      #来电号码
      t.string :callnumber, :null => false, :limit => 20
      #联系电话,手机号码
      t.string :phone, :mobile, :limit => 20
      #内容摘要
      t.string :content, :null => false, :limit => 800

      #全文检索增量更新所需
      t.boolean :delta

      t.timestamps
    end
  end

  def self.down
    drop_table :cases
  end
end
