class RegistrationsController < ApplicationController
  def create
    @registration_form = RegistrationForm.new _registration_form_params
    if @registration_form.save
      redirect_to root_path, notice: "Successfully registered"
    else
      redirect_to root_path, alert: @registration_form.errors.full_messages.to_sentence
    end
  end

  def _registration_form_params
    params.require(:registration_form).permit(
      *RegistrationForm::FIELDS,
    )
  end
end
