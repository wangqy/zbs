class CreateDuties < ActiveRecord::Migration
  def self.up
    create_table :duties do |t|
      #值班室信息:值班人员,接报人,值班领导
      t.string :watchman, :receiver, :manager, :null => false, :limit => 10
      t.references :event
    end
  end

  def self.down
    drop_table :duties
  end
end
