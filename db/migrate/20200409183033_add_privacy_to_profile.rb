class AddPrivacyToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :privacy, :json
  end
end
