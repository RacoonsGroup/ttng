class InlineObjectsController < ApplicationController
  before_filter :authenticate_admin!

  def update
    klass = params[:class_name].constantize
    object = klass.find(params[:id])
    object.send(:write_attribute, params[:attribute], params[:value])
    object.save(validate: false)
    head :ok
  end
end