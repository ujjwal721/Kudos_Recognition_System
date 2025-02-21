class CreateKudos < ActiveRecord::Migration[8.0]
  def change
    create_table :kudos do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.bigint :receiver_id, null: false  # Create column without FK
      t.text :message
      t.integer :points, default: 0

      t.timestamps
    end
    # Now add the foreign key explicitly.
    add_foreign_key :kudos, :users, column: :receiver_id
  end
end
