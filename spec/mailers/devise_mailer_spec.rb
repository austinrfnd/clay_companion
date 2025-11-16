# frozen_string_literal: true

##
# Devise Mailer Spec
#
# Tests the customized Devise email templates:
# - Confirmation instructions email
# - Password reset instructions email
#
# Verifies:
# - Emails are sent with correct subject
# - Email content matches wireframe specifications
# - Dynamic content (email addresses, URLs, tokens) are correctly rendered
# - Branded styling is present
#
require 'rails_helper'

RSpec.describe Devise::Mailer, type: :mailer do
  describe '#confirmation_instructions' do
    let(:artist) { create(:artist, email: 'test@example.com', full_name: 'Test Artist', confirmed_at: nil) }
    let(:mail) { Devise.mailer.confirmation_instructions(artist, artist.confirmation_token) }

    it 'sends email to the correct recipient' do
      expect(mail.to).to eq([artist.email])
    end

    it 'has the correct subject' do
      expect(mail.subject).to include('Confirm')
    end

    it 'has the correct sender' do
      expect(mail.from).to include('noreply@claycompanion.com')
    end

    it 'includes the artist email address in the body' do
      expect(mail.body.encoded).to include(artist.email)
    end

    it 'includes the confirmation URL in the body' do
      expect(mail.body.encoded).to include('email/verify')
      expect(mail.body.encoded).to include(artist.confirmation_token)
    end

    it 'includes the confirmation button text' do
      expect(mail.body.encoded).to include('Confirm my account')
    end

    it 'includes the Clay Companion branding' do
      expect(mail.body.encoded).to include('Clay Companion')
    end

    it 'includes the expiry notice' do
      expect(mail.body.encoded).to include('24 hours')
    end

    it 'includes the security notice' do
      expect(mail.body.encoded).to include("didn't create an account")
    end

    it 'includes the support contact information' do
      expect(mail.body.encoded).to include('support@claycompanion.com')
    end

    it 'uses HTML format' do
      expect(mail.content_type).to include('text/html')
    end

    it 'includes the logo image reference' do
      expect(mail.body.encoded).to include('clay_companion_logo.png')
    end
  end

  describe '#reset_password_instructions' do
    let(:artist) { create(:artist, email: 'test@example.com', full_name: 'Test Artist') }
    let(:mail) { Devise.mailer.reset_password_instructions(artist, artist.reset_password_token) }

    before do
      # Generate a reset password token
      artist.send_reset_password_instructions
      artist.reload
    end

    it 'sends email to the correct recipient' do
      expect(mail.to).to eq([artist.email])
    end

    it 'has the correct subject' do
      expect(mail.subject).to include('password')
    end

    it 'has the correct sender' do
      expect(mail.from).to include('noreply@claycompanion.com')
    end

    it 'includes the artist email address in the greeting' do
      expect(mail.body.encoded).to include(artist.email)
    end

    it 'includes the password reset URL in the body' do
      expect(mail.body.encoded).to include('password/reset')
      # The token will be in the URL
      expect(mail.body.encoded).to include(artist.reset_password_token)
    end

    it 'includes the reset button text' do
      expect(mail.body.encoded).to include('Change my password')
    end

    it 'includes the Clay Companion branding' do
      expect(mail.body.encoded).to include('Clay Companion')
    end

    it 'includes the expiry notice' do
      expect(mail.body.encoded).to include('6 hours')
    end

    it 'includes the security notices' do
      expect(mail.body.encoded).to include("didn't request this")
      expect(mail.body.encoded).to include("won't change until")
    end

    it 'includes the support contact information' do
      expect(mail.body.encoded).to include('support@claycompanion.com')
    end

    it 'uses HTML format' do
      expect(mail.content_type).to include('text/html')
    end

    it 'includes the logo image reference' do
      expect(mail.body.encoded).to include('clay_companion_logo.png')
    end
  end
end

