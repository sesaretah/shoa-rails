class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :title
      t.json :settings

      t.timestamps
    end
  end
end
