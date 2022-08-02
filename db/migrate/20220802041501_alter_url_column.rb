class AlterUrlColumn < ActiveRecord::Migration[7.0]
  def change
    remove_index :images, %w[url], name: :images_url
    change_column :images, :url, :text
  end
end
