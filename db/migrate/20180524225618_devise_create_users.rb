# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name,               default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.timestamp :reset_password_sent_at

      ## Rememberable
      t.timestamp :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, null: false, default: 0
      t.timestamp :current_sign_in_at
      t.timestamp :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.timestamp :confirmed_at
      # t.timestamp :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, null: false, default: 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.timestamp :locked_at

      t.boolean :is_enabled, null: false, default: true
      t.boolean :is_admin, null: false, default: false

      ## Omniauthable (JP)
      t.string :provider, index: true
      t.string :uid, index: true

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
