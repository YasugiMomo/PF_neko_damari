class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.bigint :customer, limit: 20
      t.bigint :review, limit: 20

      t.timestamps
    end
    add_foreign_key :customer,:review
  end
end
