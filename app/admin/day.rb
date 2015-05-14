ActiveAdmin.register Day do
  permit_params :date, :holiday, :reason

  form do |f|
    f.inputs do
      f.input :date, as: :datepicker
      f.input :holiday
      f.input :reason
    end
    f.inputs do
      f.action :submit
    end
  end
end
