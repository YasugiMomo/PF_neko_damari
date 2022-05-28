class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.bigint :review, limit: 20
      t.bigint :tag, limit: 20

      t.timestamps
    end
    add_foreign_key :review,:tag
  end
end
