class CreateLegislatures < ActiveRecord::Migration[6.0]
  def change
    create_table :legislatures do |t|
      t.integer :legislature_number, precision: 4
      t.integer :legislature_code, null: false
      t.string :parliamentary_card, null: false
      t.string :state, null: false, null: false
      t.string :political_party, null: false

      t.references :deputy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
