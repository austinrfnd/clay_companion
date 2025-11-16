# frozen_string_literal: true

##
# Application Helper
#
# Provides reusable helper methods for views across the application.
# Includes helpers for error messages, flash messages, and other common UI patterns.
#
module ApplicationHelper
  ##
  # Renders an inline error message for form fields
  #
  # Matches the wireframe error message pattern:
  # - Red background (10% opacity)
  # - Red border
  # - Warning icon
  # - Proper ARIA attributes for accessibility
  #
  # @param message [String] The error message to display
  # @param field_id [String, nil] Optional field ID to create unique error message ID
  # @return [String] HTML string for the error message
  #
  # @example
  #   error_message('Email is required', field_id: 'email')
  #   # => <div class="error-message..." id="email_error">⚠️ Email is required</div>
  def error_message(message, field_id: nil)
    return '' if message.blank?

    error_id = field_id ? "#{field_id}_error" : nil

    content_tag :div,
      class: 'error-message mt-2 p-3 bg-error/10 border border-error rounded-md text-error text-sm',
      id: error_id,
      role: 'alert',
      aria: { live: 'polite' } do
      "⚠️ #{message}".html_safe
    end
  end

  ##
  # Renders a flash message with appropriate styling based on type
  #
  # Supports multiple flash types:
  # - :notice, :success → Green styling with checkmark
  # - :alert, :error → Red styling with warning icon
  # - :warning → Orange styling with warning icon
  # - :info → Blue styling with info icon
  #
  # Matches the wireframe flash message pattern and design system colors.
  #
  # @param type [Symbol, String] The flash message type (:notice, :success, :alert, :error, :warning, :info)
  # @param message [String] The flash message to display
  # @return [String] HTML string for the flash message, or empty string if message is blank
  #
  # @example
  #   flash_message(:success, 'Account created!')
  #   # => <div class="flash-message flash-message-success...">✓ Account created!</div>
  def flash_message(type, message)
    return nil if message.blank?

    # Map flash types to CSS classes and icons
    bg_color = case type.to_sym
               when :notice, :success
                 'bg-success/10 border-success text-success'
               when :alert, :error
                 'bg-error/10 border-error text-error'
               when :warning
                 'bg-warning/10 border-warning text-warning'
               when :info
                 'bg-info/10 border-info text-info'
               else
                 'bg-slate/10 border-slate text-slate'
               end

    icon = case type.to_sym
           when :notice, :success then '✓'
           when :alert, :error then '⚠️'
           when :warning then '⚠️'
           when :info then 'ℹ️'
           else ''
           end

    content_tag :div,
      class: "flash-message p-3 border rounded-md text-sm #{bg_color}",
      role: 'alert',
      aria: { live: 'polite' },
      tabindex: '0',
      data: { controller: 'flash', action: 'keydown->flash#handleKeydown' } do
      "#{icon} #{message}".html_safe +
      content_tag(:button,
        type: 'button',
        class: 'flash-message-close',
        aria: { label: 'Close message' },
        data: { action: 'click->flash#dismiss' }) do
        '×'
      end
    end
  end
end
