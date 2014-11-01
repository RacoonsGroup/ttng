class ProjectPermitter < Permitter
  fields [:customer_id, :name, :rate, :description, customer: [:id], users: [user: [:id]]]
  namespace :project

  after_permit do |params|
    params[:users] = (params[:users] || []).map{|u| u[:user]}
  end
end