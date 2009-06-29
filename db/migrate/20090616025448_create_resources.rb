class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :name, :null => false, :limit => 20
      t.string :code, :null => false, :limit => 20
      t.string :path, :limit => 50
      t.string :css, :limit => 10
      t.integer :sequence, :null => false, :default => 0
      t.integer :parent_id
    end

    say 'init resource'

    event = Resource.create!({:name => '事件管理', :code => 'event', :sequence => 0})
    Resource.create!({:name => '待办事项', :code => 'workitems', :parent => event, :path => '/workitems', :css => '63', :sequence => 1})
    Resource.create!({:name => '受理事件', :code => 'conversations', :parent => event, :path => '/conversations', :css => '32', :sequence => 2})
    Resource.create!({:name => '事件调度', :code => 'dispatches', :parent => event, :path => '/dispatches', :css => '62', :sequence => 3})
    Resource.create!({:name => '添加往来记录', :code => 'events', :parent => event, :path => '/events', :css => '31', :sequence => 4})

    central = Resource.create!({:name => '资源中心', :code => 'central', :sequence => 20})
    Resource.create!({:name => '事件记录', :code => 'searches', :parent => central, :path => '/searches', :css => '34', :sequence => 21})
    Resource.create!({:name => '录音记录', :code => 'records', :parent => central, :path => '/records', :css => '33', :sequence => 22})

    system = Resource.create!({:name => '系统管理', :code => 'system', :sequence => 90})
    Resource.create!({:name => '机构管理', :code => 'departments', :parent => system, :path => '/departments/new', :css => '31', :sequence => 91})
    Resource.create!({:name => '用户管理', :code => 'users', :parent => system, :path => '/users', :css => '41', :sequence => 92})
    Resource.create!({:name => '系统日志', :code => 'logs', :parent => system, :path => '/logs', :css => '53', :sequence => 93})
    Resource.create!({:name => '公告管理', :code => 'notices', :parent => system, :path => '/notices', :css => '64', :sequence => 94})
  end

  def self.down
    drop_table :resources
  end
end
