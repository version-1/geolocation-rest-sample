class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.uuid :uuid, default: -> { 'gen_random_uuid()' }, null: false
      t.string :username, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :users, :uuid, unique: true
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
