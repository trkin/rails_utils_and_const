# https://github.com/duleorlovic/rails_utils_and_const/blob/main/config/initializers/console_helpers.rb
#
# You can copy and paste this to console if you need to update it
def item_url(item)
  case item
  when User
    Rails.application.routes.url_helpers.users_url(item, host: item.host)
  else
    "unknown_item_url for class=#{item.class}"
  end
end
