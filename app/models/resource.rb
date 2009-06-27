class Resource < ActiveRecord::Base
  belongs_to :parent, :class_name => "Resource"
  has_many :children, :class_name => "Resource", :foreign_key => "parent_id"
  has_many :permissions
  has_many :users, :through => :permissions

  named_scope :top, :conditions => ["parent_id is null"]

  #一级菜单为key，根据一级菜单找出二级菜单
  def self.menu_hash_from(user)
    hashes = {}
    sub_menus = user.resources
    sub_menus.each do |sub_menu|
      parent = sub_menu.parent
      sub_menu_array = []
      if hashes.has_key?(parent)
        sub_menu_array = hashes[parent]
      else
        hashes[parent] = sub_menu_array
      end
      sub_menu_array << sub_menu
      self.sort!(sub_menu_array)
    end
    hashes
  end

  #一级菜单
  def self.menu_from(menu_hashes)
    self.sort!(menu_hashes.keys)
  end

  def self.sort!(array)
    array.sort! {|x,y| x.sequence <=> y.sequence}
  end
end
