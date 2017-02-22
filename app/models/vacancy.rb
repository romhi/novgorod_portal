class Vacancy < ActiveRecord::Base

  belongs_to :volunteer
  validates_presence_of :name, :starts_at, :ends_at
  validates_uniqueness_of :volunteer_id, if: "volunteer_id.present?"
  scope :by_location, -> (location_number){ where("name ilike ?", "%пост №#{location_number}%" ).order(:number) }
  scope :by_number, -> (number){ where("number = ?", number ).first }
  scope :without_volunteer, -> { where("volunteer_id is null").order(:number) }

  def full_info
    "#{starts_at.strftime("%H:%M")}-#{ends_at.strftime("%H:%M")} #{name}"
  end


end
