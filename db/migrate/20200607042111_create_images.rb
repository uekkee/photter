class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :url

      t.timestamps
    end

    add_index :images, :url, name: :images_url, unique: true
  end
end
