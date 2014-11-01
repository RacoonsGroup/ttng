class Admin::CustomersController < Admin::AdminController
  load_and_authorize_resource
  inject :customer_manager

  def index
    @customers = @customers.paginate(page: params[:page])
  end

  def new

  end

  def create
    customer_manager.create(customer_params) do |customer, saved|
      if saved
        redirect_to admin_customers_path
      else
        @customer = customer
        render :new
      end
    end
  end

  def edit

  end

  def update
    customer_manager.update(@customer, customer_params) do |customer, saved|
      if saved
        redirect_to admin_customers_path
      else
        @customer = customer
        render :edit
      end
    end
  end

  def destroy
    customer_manager.destroy(@customer)
    redirect_to admin_customers_path
  end

  private

  def customer_params
    fields = [:name]
    params.require(:customer).permit(fields)
  end
end
