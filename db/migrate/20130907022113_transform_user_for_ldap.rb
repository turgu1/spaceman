class TransformUserForLdap < ActiveRecord::Migration[5.1]
  def up

    User.all.each { |u| u.destroy! }

    remove_column :users, :email
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at

    #remove_index  :users, :email
    #remove_index  :users, :reset_password_token

    add_column    :users,    :username, :string,   default: '', null: false

    add_index     :users,    :username, unique: true
  end

  def down
    ## Database authenticatable
    add_column :users, :email,                  :string, default: ''
    add_column :users, :encrypted_password,     :string, default: ''

    ## Recoverable
    add_column :users, :reset_password_token,   :string
    add_column :users, :reset_password_sent_at, :datetime

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
