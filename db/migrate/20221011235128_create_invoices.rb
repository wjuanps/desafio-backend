class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.integer :document_number, null: false, limit: 8
      t.integer :document_type, null: false
      t.datetime :issue_date
      t.decimal :document_value, precision: 10, scale: 2
      t.decimal :gross_value, precision: 10, scale: 2
      t.decimal :net_value, precision: 10, scale: 2
      t.integer :year
      t.integer :month
      t.integer :installments
      t.string :passenger_name
      t.string :leg_trip
      t.integer :batch
      t.integer :refund
      t.integer :restitution
      t.string :document_url
      t.integer :requester_id

      t.references :deputy, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true
      t.references :deputy_quota, null: false, foreign_key: true

      t.timestamps
    end
  end
end
