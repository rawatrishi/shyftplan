class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :parent_id, index: true
      t.integer :required_employee, default: 0
      t.integer :total_employee, default: 0
      t.references :country

      t.timestamps
    end
  end
end
