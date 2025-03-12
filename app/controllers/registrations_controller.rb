class RegistrationsController < ApplicationController
  def show
    @registration_form = RegistrationForm.new _registration_form_params
  end

  def create
    @registration_form = RegistrationForm.new _registration_form_params
    if @registration_form.save
      redirect_to root_path, notice: "Successfully registered"
    else
      redirect_to root_path, alert: @registration_form.errors.full_messages.to_sentence
    end
  end

  def _registration_form_params
    # on GET we do not have params so we use {}, we need for .merge
    params.fetch(:registration_form, {}).permit(
      *RegistrationForm::FIELDS,
    ).merge(
      user: current_user,
    )
  end
end
