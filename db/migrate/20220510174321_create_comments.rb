class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.bigint :review_id, limit: 20
      t.bigint :customer_id, limit: 20
      t.text :comment, null: false

      t.timestamps
    end
    add_foreign_key :comments, :reviews
    add_foreign_key :comments, :customers
    # add_foreign_key :対象のテーブル名, :指定先のテーブル
  end
end
