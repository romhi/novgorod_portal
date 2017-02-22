class Congregation < ActiveRecord::Base

  belongs_to :city
  has_many :volunteers
  validates_presence_of :name, :number, :city_id

  def full_info
    "#{city.name} #{name} (#{number})"
  end

end
