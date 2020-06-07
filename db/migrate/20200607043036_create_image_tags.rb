class CreateImageTags < ActiveRecord::Migration[6.0]
  def change
    create_table :image_tags do |t|
      t.references :image, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :image_tags, %i(image_id tag_id), name: :image_tags_image_tag, unique: true
  end
end
