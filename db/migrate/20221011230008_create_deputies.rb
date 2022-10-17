class CreateDeputies < ActiveRecord::Migration[6.0]

  def change
    create_table :deputies do |t|
      t.integer :deputy_identifier, null: false, unique: true
      t.string :taxpayer,  null: false, unique:  true
      t.string :name, null: false

      t.timestamps
    end
  end

end
