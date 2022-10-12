class CreateQuota < ActiveRecord::Migration[6.0]
  def change
    create_table :quota do |t|
      t.integer :sub_quota_number, null: false
      t.string :description
      t.integer :sub_quota_esoecification_number
      t.string :description_especification

      t.references :legislature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
