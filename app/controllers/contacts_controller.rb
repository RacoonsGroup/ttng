class ContactsController < AuthenticatedController
	load_and_authorize_resource
  inject :contact_manager
  helper_method :sort_column, :sort_direction

  def index
    @contacts = @contacts.search(params[:search]).order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 20)
  end

  def new

  end

  def create
    contact_manager.create(contact_params) do |contact, saved|
      if saved
        redirect_to contacts_path
      else
        @contact = contact
        render :new
      end
    end
  end

  def edit

  end

  def update
    contact_manager.update(@contact, contact_params) do |contact, saved|
      if saved
        redirect_to contacts_path
      else
        @contact = contact
        render :edit
      end
    end
  end

  def destroy
    contact_manager.destroy(@contact)
    redirect_to contacts_path
  end

  private

  def contact_params
  	ContactPermitter.permit(params)
  end

  def sort_column
    Contact.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end
end
