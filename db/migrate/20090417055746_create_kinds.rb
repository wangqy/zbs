class CreateKinds < ActiveRecord::Migration
  def self.up
    create_table :kinds do |t|
      t.string :name, :null => false, :limit => 20
      t.integer :parent_id

      t.timestamps
    end

    say 'create empty option'
    Kind.create!({:name => '未选择'})
  end

  def self.down
    drop_table :kinds
  end
end
