class City < ActiveRecord::Base

  belongs_to :region
  has_many :congregations
  validates_presence_of :name, :region_id

end
