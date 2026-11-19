module ApplicationHelper
  def user_avatar(user)
    user.avatar.attached? ? user.avatar : "default_user.png"
  end

  def room_image(room)
    room.image.attached? ? room.image : "default_user.png"
  end
end
