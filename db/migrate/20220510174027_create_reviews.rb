class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.bigint :customer_id, limit: 20
      t.bigint :shop_id, limit: 20
      t.string :title
      t.text :content
      t.float :rate, null: false, default: "0"

      t.timestamps
    end
    add_foreign_key :reviews, :customers
    add_foreign_key :reviews, :shops
    # add_foreign_key :対象のテーブル名, :指定先のテーブル
  end
end
