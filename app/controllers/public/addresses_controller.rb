class Public::AddressesController < ApplicationController

  def index
    @customer = current_customer
    @address = Address.new
    @addresses = @customer.addresses
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    end
  end

 private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
