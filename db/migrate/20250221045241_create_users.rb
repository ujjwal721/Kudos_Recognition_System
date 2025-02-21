class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.integer :role, null: false   # Custom role (managed in model)
      t.string  :password_digest
      t.integer :leaderboard_score, default: 0

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

