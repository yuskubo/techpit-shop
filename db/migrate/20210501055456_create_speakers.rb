class CreateSpeakers < ActiveRecord::Migration[6.1]
  def change
    create_table :speakers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company
      t.text :profile

      t.timestamps
    end
  end
end
