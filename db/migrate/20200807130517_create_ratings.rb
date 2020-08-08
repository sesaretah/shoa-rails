class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
  end
end
