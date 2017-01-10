class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :status, deafult: 0
      t.references :user, foreign_key: true
      t.date :updated_at,  null: false
      t.date :created_at,  null: false
    end
  end
end
