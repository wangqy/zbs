class CreateSequences < ActiveRecord::Migration
  def self.up
    create_table :sequences do |t|
      t.date :day, :null => false
      t.integer :number, :null => false, :default => 1
    end
  end

  def self.down
    drop_table :sequences
  end
end
