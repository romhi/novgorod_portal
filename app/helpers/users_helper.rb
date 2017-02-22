module UsersHelper

  def role(user)
     if user.admin?
       "Админ"
     elsif user.manager?
      "Менеджер"
     else
      "Нет"
     end
  end

end
