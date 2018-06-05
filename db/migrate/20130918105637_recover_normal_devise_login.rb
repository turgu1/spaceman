class RecoverNormalDeviseLogin < ActiveRecord::Migration[5.1]
  def change
    ## Database authenticatable
    add_column :users, :email,                  :string, default: ''
    add_column :users, :encrypted_password,     :string, default: ''

    ## Recoverable
    add_column :users, :reset_password_token,   :string
    add_column :users, :reset_password_sent_at, :datetime

    add_index :users, :reset_password_token,    unique: true
  end
end
