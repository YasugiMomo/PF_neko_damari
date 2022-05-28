class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.bigint :customer_id, limit: 20
      t.bigint :review_id, limit: 20

      t.timestamps
    end
    add_foreign_key :favorites, :customers
    add_foreign_key :favorites, :reviews
    # add_foreign_key :対象のテーブル名, :指定先のテーブル
  end
end
