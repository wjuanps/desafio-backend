class CreateLegislatures < ActiveRecord::Migration[6.0]

  def change
    create_table :legislatures do |t|
      t.integer :legislature_number
      t.integer :legislature_code
      t.string :parliamentary_card
      t.string :state
      t.string :political_party

      t.references :deputy, null: false, foreign_key: true

      t.timestamps
    end
  end

end
