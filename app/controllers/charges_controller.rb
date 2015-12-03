class ChargesController < ApplicationController

  def create
    #creating stripe customer object to associating with charge
    customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd')

    # raise charge.inspect
    current_user.update_attributes(role: 'premium_user', stripe_id: customer.id)
    flash[:success] = "Thanks for subscribing, #{current_user.email}!"
    redirect_to  root_path

    #Stripe will send back CardErrors, when something goes wrong
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to  new_charge_path
  end

  def new
    # raise Rails.configuration.stripe.inspect
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Blocipedia Premium Membership - #{current_user.name}",
      amount: @amount
    }
  end
end
