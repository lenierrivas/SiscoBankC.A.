class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :type_person
      t.string :identification
      t.date :emit
      t.date :expiration
      t.string :name
      t.string :email
      t.string :tlf
      t.string :tlf_second

      t.timestamps
    end
  end
end
