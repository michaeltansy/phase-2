class WelcomeController < ApplicationController
  def index
    @order = Order.all
  end
end
