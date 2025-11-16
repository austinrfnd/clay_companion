# frozen_string_literal: true

##
# Profile Completeness Concern
#
# Provides shared functionality for checking if an artist's profile is complete.
# Used by authentication controllers to determine redirect paths after login/confirmation.
#
# Profile is considered incomplete if full_name is missing.
# Location is optional per wireframe requirements.
#
module ProfileCompleteness
  extend ActiveSupport::Concern

  private

  ##
  # Check if artist profile is incomplete
  # Profile is incomplete if full_name is missing (location is optional per wireframe)
  #
  # @param artist [Artist] The artist to check
  # @return [Boolean] True if profile is incomplete
  def profile_incomplete?(artist)
    artist.full_name.blank?
  end
end

