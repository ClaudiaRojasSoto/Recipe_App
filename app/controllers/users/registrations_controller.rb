class Users::RegistrationsController < Devise::RegistrationsController
  private

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
