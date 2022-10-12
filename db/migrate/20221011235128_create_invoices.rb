class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.integer :document_number, null: false
      t.integer :document_type, null: false, limit: 3
      t.datetime :issue_date
      t.integer :document_value
      t.integer :gross_value
      t.integer :net_value
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :installments
      t.string :passenger_name
      t.string :leg_trip
      t.integer :batch
      t.integer :refund
      t.integer :restitution
      t.string :document_url
      t.integer :requester_id, null: false

      t.references :quota, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
