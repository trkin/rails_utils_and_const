# https://github.com/duleorlovic/rails_helpers_and_const/blob/main/config/initializers/my_aliases.rb
# In rails console you can quickly use this helpers
#   rails c
#   me # => User
#
# To ignore in all your projects you can use
# ~/.gitconfig
# [core]
#   exlcudesfile = ~/.gitignore_global
# ~/.gitignore_global
# config/initializers/my_aliases.rb
def me
  User.find_by(email: "duleorlovic@gmx.com")
end
