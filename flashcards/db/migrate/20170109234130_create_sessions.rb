class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.belongs_to :user, index: true
      
      t.string :token
      t.timestamps
    end

    add_index :sessions, :token, unique: true
  end
end
