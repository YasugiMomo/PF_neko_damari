class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.text :content
      t.float :score

      t.timestamps
    end
  end
end
