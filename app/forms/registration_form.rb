# https://github.com/duleorlovic/rails_utils_and_const/blob/main/app/forms/registration_form.rb
class RegistrationForm
  include ActiveModel::Model
  # uncomment if you use before_validation :_set_user callbacks
  # note that :_set_user is called when `valid?` is called
  # include ActiveModel::Validations::Callbacks

  FIELDS = %i[email password].freeze
  attr_accessor :user, *FIELDS

  # Serialize inputs using https://stackoverflow.com/a/8940255/287166
  # casting_attr_accessor *FIELDS, Float

  validates(*FIELDS, presence: true)

  # if you need to customize prepopulate fields
  def initialize(attributes = {})
    super(attributes)
    return if email.present? # return if we populate from params

    @email = user&.email
  end

  def save
    return false unless valid?

    return false unless _create_user_successfully?

    true
  end

  def _create_user_successfully?
    if password.size < 5
      errors.add :base, "Please use longer password"
      false
    else
      true
    end
  end
end
