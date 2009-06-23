class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.references :user
      t.references :resource
    end

    say 'init user resource'
    u = User.find_by_login('admin')
    system = Resource.find_by_code('system')
    u.resources << system.children
    u.save!
  end

  def self.down
    drop_table :permissions
  end
end
