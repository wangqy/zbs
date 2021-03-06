class Kind < ActiveRecord::Base
  belongs_to :parent, :class_name => "Kind"
  has_many :childrens, :class_name => "Kind", :foreign_key => "parent_id"

  validates_presence_of :name, :days
  validates_numericality_of :days, :allow_nil => true

  named_scope :parent_list, lambda {
    {
      :conditions => ["parent_id is null"],
      :order => "id asc"
    }
  }
end
