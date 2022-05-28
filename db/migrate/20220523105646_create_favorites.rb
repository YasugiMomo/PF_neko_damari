class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.bigint :customer_id, limit: 20
      t.bigint :review_id, limit: 20

      t.timestamps
    end
    add_foreign_key :customer,:review
  end
end
