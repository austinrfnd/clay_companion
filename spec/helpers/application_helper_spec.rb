# frozen_string_literal: true

##
# Application Helper Spec
#
# Tests helper methods for error messages and flash messages.
# Verifies helpers match wireframe patterns and design system.
#
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#error_message' do
    it 'renders an error message with proper styling' do
      result = helper.error_message('Email is required', field_id: 'email')
      expect(result).to include('error-message')
      expect(result).to include('Email is required')
      expect(result).to include('⚠️')
    end

    it 'includes the field ID in the error message ID' do
      result = helper.error_message('Password too short', field_id: 'password')
      expect(result).to include('id="password_error"')
    end

    it 'has proper ARIA attributes for accessibility' do
      result = helper.error_message('Invalid input')
      expect(result).to include('role="alert"')
      expect(result).to include('aria-live="polite"')
    end

    it 'applies error styling classes' do
      result = helper.error_message('Test error')
      expect(result).to include('bg-error/10')
      expect(result).to include('border-error')
      expect(result).to include('text-error')
    end

    context 'when field_id is not provided' do
      it 'renders error message without field-specific ID' do
        result = helper.error_message('General error')
        expect(result).not_to include('_error"')
      end
    end
  end

  describe '#flash_message' do
    it 'renders nothing when message is blank' do
      result = helper.flash_message(:notice, '')
      expect(result).to be_nil
    end

    it 'renders nothing when message is nil' do
      result = helper.flash_message(:notice, nil)
      expect(result).to be_nil
    end

    context 'success/notice messages' do
      it 'renders success flash message with green styling' do
        result = helper.flash_message(:success, 'Account created!')
        expect(result).to include('flash-message')
        expect(result).to include('Account created!')
        expect(result).to include('✓')
        expect(result).to include('bg-success/10')
        expect(result).to include('border-success')
        expect(result).to include('text-success')
      end

      it 'renders notice flash message with success styling' do
        result = helper.flash_message(:notice, 'Welcome back!')
        expect(result).to include('bg-success/10')
        expect(result).to include('✓')
      end
    end

    context 'error/alert messages' do
      it 'renders error flash message with red styling' do
        result = helper.flash_message(:error, 'Something went wrong')
        expect(result).to include('bg-error/10')
        expect(result).to include('border-error')
        expect(result).to include('text-error')
        expect(result).to include('⚠️')
      end

      it 'renders alert flash message with error styling' do
        result = helper.flash_message(:alert, 'Invalid credentials')
        expect(result).to include('bg-error/10')
        expect(result).to include('⚠️')
      end
    end

    context 'warning messages' do
      it 'renders warning flash message with orange styling' do
        result = helper.flash_message(:warning, 'Please review your settings')
        expect(result).to include('bg-warning/10')
        expect(result).to include('border-warning')
        expect(result).to include('text-warning')
        expect(result).to include('⚠️')
      end
    end

    context 'info messages' do
      it 'renders info flash message with blue styling' do
        result = helper.flash_message(:info, 'New features available')
        expect(result).to include('bg-info/10')
        expect(result).to include('border-info')
        expect(result).to include('text-info')
        expect(result).to include('ℹ️')
      end
    end

    it 'has proper ARIA attributes for accessibility' do
      result = helper.flash_message(:notice, 'Test message')
      expect(result).to include('role="alert"')
      expect(result).to include('aria-live="polite"')
    end
  end
end

