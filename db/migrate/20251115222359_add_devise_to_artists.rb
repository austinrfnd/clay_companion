# frozen_string_literal: true

##
# Add Devise Authentication Fields to Artists
#
# Adds Devise authentication fields to the artists table.
# Note: email field already exists, so we only add Devise-specific fields.
#
# Fields Added:
# - encrypted_password: Bcrypt hashed password
# - reset_password_token: Token for password reset
# - reset_password_sent_at: Timestamp when reset email was sent
# - remember_created_at: Timestamp for "remember me" functionality
# - confirmation_token: Token for email confirmation
# - confirmed_at: Timestamp when email was confirmed
# - confirmation_sent_at: Timestamp when confirmation email was sent
# - unconfirmed_email: Email address pending confirmation
#
class AddDeviseToArtists < ActiveRecord::Migration[7.2]
  def self.up
    change_table :artists do |t|
      ## Database authenticatable
      # Note: email field already exists, so we don't add it here
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
    end

    # Note: email index already exists, so we don't add it here
    add_index :artists, :reset_password_token, unique: true
    add_index :artists, :confirmation_token,   unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
