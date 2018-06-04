class Schools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |s|
      s.timestamps
      s.string :nom
      s.string :adresse
      s.string :zip_code
      s.string :city
      s.string :openings
      s.string :phone
      s.string :email
      s.integer :nb_student
      s.string :status
      s.float :latitude
      s.float :longitude
    end
  end
end
