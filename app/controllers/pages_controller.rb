class PagesController < ApplicationController
  def index
    @registration_form = RegistrationForm.new
  end
end
