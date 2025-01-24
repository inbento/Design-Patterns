class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :last_name_and_initials
      t.string :passport
      t.string :telephone

      t.timestamps
    end
  end
end
