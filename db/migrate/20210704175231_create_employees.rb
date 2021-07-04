class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :email
      t.string :contact
      t.string :name
      t.references :company
      t.references :branch

      t.timestamps
    end
  end
end
