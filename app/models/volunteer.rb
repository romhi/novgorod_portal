class Volunteer < ActiveRecord::Base

  belongs_to :congregation
  belongs_to :responsibility
  has_one :vacancy
  scope :by_congregation_id, -> congregation_id { where("congregation_id = ?", congregation_id) }
  scope :without_vacancies, -> { where("id not in (?)", Vacancy.where("volunteer_id is not null").pluck(:volunteer_id))}

  validates :age, numericality: { greater_than: 18}
  validates_presence_of :congregation_id, :last_name, :first_name, :age,
                        :convenient_start_time, :convenient_end_time, :will_be_since_8, :car,
                        :will_be_until_17, :outdoor, :phone, :responsibility_id

  def full_info
    "#{congregation.city.region.name[0]}.обл. #{congregation.name} #{last_name.strip} #{first_name} #{age}л. / (#{responsibility.name}) /  время #{convenient_time} #{"/ Улица" if outdoor == 1} / #{comment}"
  end

  def full_info_for_print
    "#{congregation.city.region.name[0]}.#{congregation.name} (#{responsibility.name}) #{last_name.strip} #{first_name} #{age}"
  end

  def convenient_time
    "#{convenient_start_time.strftime("%H:%M")}-#{convenient_end_time.strftime("%H:%M")}"
  end

  def city_and_congregation
    congregation.city.name == congregation.name ? "#{congregation.name}" : "#{congregation.city.name} #{congregation.name}"
  end

  def self.without_vacancy
    if Vacancy.where("volunteer_id is not null").pluck(:volunteer_id).count > 0
      self.where("id not in (?)", Vacancy.where("volunteer_id is not null").pluck(:volunteer_id)).order(:congregation_id)
    else
      self.order(:congregation_id)
    end
  end

end
