class ProjectPresenter < Presenter
  expose_all

  def to_hash
    {
        id: id,
        name: name,
        rate: rate.to_f,
        description: description,
        customer: customer,
        pivotal_id: pivotal_id,
        users: users.map{ |u| {user: UserPresenter.new(u).to_hash } }
    }
  end
end