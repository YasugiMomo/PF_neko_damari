class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :customer, type: :bigint, foreign_key: true
      t.references :review, type: :bigint, foreign_key: true

      t.timestamps
    end
  end
end
