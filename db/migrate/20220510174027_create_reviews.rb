class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :custoemr, type: :bigint, foreign_key: true
      t.references :shop, type: :bigint, foreign_key: true
      t.string :title
      t.text :content
      t.float :rate, null: false, default: "0"

      t.timestamps
    end
  end
end
