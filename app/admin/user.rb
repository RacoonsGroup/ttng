ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :mobile, :position, :inn, :snils, :pivotal_token, :google_token

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :mobile
      f.input :position, collection: User.positions.keys, as: :select
      f.input :inn
      f.input :snils
      f.input :pivotal_token
      f.input :google_token
    end
    f.inputs do
      f.action :submit
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column :created_at
    actions
  end

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end
end
