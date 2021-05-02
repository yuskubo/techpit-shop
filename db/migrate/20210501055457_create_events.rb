class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :speaker, null: false, foreign_key: true
      t.string :title, null: false
      t.string :sub_title, null: false
      t.text :content, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
