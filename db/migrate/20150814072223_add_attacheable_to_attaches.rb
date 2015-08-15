class AddAttacheableToAttaches < ActiveRecord::Migration
  def change
    add_reference :attaches, :attacheable, polymorphic: true, index: true
  end
end
