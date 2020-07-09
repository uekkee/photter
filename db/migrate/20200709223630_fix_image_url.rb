class FixImageUrl < ActiveRecord::Migration[6.0]
  def change
    execute('ALTER TABLE images MODIFY url varchar(255) BINARY')
  end
end
