class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Blocipedia Premium Membership - #{current_user.name}", 
      amount: @amount
    }
  end
  
  def create
    @amount = 15_00
    #creating stripe customer object to associating with charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd')

    flash[:success] = "Thanks for subscribing, #{current_user.email}! Feel free to pay me again."
    redirect_to  user_path(current_user)

    #Stripe will send back CardErrors, when something goes wrong
  rescue Stripe::cardError => e
    flash[:error] = e.message
    redirect_to  new_charge_path


  end 





end
