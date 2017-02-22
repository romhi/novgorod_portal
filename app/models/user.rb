class User < ActiveRecord::Base

  belongs_to :responsibility
  belongs_to :city
  belongs_to :congregation
  has_many :messages
  validates_presence_of :first_name, :last_name, :email, :phone
  scope :managers, ->{ where("manager = 1").order(:first_name)}
  scope :admins, -> { where("admin = true") }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  def self.current_user
    Thread.current[:current_user]
  end

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def admin?
    admin
  end

  def manager?
    manager == 1
  end

  def full_info
    "#{last_name.strip} #{first_name[0]}"
  end

end
