class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.bigint :review_id, limit: 20
      t.bigint :tag_id, limit: 20

      t.timestamps
    end
    add_foreign_key :tagmaps, :reviews
  end
end
