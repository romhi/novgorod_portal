class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :author, class_name: User
  scope :by_user_id, ->{ select("max(id) as id, user_id, count(message) as qty, sum(admin_read) as new").group(:user_id).order(:user_id)}
  scope :new_for_admin, ->{ where("admin_read = 1") }
  scope :new_for_user, -> user_id { where("user_id = ? and user_read = 1", user_id) }
  default_value_for :user_read, 1
  default_value_for :admin_read, 1
  validates_presence_of :user_id, :author_id

  after_create :send_notification

  def send_notification
    if author.admin?
      Messages.new_message(user).deliver
    else
      User.admins.each do |user|
      Messages.new_message(user).deliver
      end
    end
  end

end
