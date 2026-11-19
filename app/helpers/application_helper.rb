module ApplicationHelper
  def user_avatar(user)
    user.avatar.attached? ? user.avatar : "default_user.png"
  end

  def room_image(room)
    if room.respond_to?(:image) && room.image.attached?
      room.image
    else
      "default_room.png"
    end
  end
end