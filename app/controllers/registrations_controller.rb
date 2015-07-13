class RegistrationsController < Devise::RegistrationsController

  def downgrade
    current_user.update_attributes(role: "standard", stripe_id: nil, stripe_subscription: nil)
    flash[:success] = "Your premium membeship subscription has been cancelled."
    redirect_to root_path
  end  

end