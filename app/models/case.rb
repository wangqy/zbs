class Case < ActiveRecord::Base
  has_many :events

  define_index do
    indexes :callnumber, :phone, :mobile
    has :created_at
    set_property :delta => true
  end

end
