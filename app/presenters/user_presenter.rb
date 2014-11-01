class UserPresenter < Presenter
  expose_all

  def to_hash
    {
        id: id,
        full_name: full_name_with_position
    }
  end
end