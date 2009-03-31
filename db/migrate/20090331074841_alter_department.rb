class AlterDepartment < ActiveRecord::Migration
  def self.up
    remove_column (:departments,:code_prefix,:code_suffix)
    add_column :departments, :code, :string, :limit=>10
  end

  def self.down
    remove_column :departments, :code
    add_column :departments, :code_prefix, :string, :limit=>3
    add_column :departments, :code_suffix, :string, :limit=>10
  end
end
