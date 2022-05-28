class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.references :review, type: :bigint, foreign_key: true
      t.references :tag, type: :bigint, foreign_key: true

      t.timestamps
    end
  end
end
