class AddStoreIdToSpreeSlides < ActiveRecord::Migration
  def change
    add_reference :spree_slides, :store, index: true
  end
end
