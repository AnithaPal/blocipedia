class RegistrationsController < Devise::RegistrationsController

  def downgrade
    current_user.update_attributes(role: "standard")
    current_user.wikis each do |wiki|
      wiki.update_attributes(private: false)
    end  
    flash[:success] = "Your premium membeship subscription has been cancelled."
    redirect_to root_path
  end  

end