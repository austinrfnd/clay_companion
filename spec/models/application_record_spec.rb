# frozen_string_literal: true

##
# ApplicationRecord Spec
#
# Sanity check spec to verify RSpec configuration is working correctly.
# Tests that ApplicationRecord inherits from ActiveRecord::Base.

require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'inheritance' do
    it 'inherits from ActiveRecord::Base' do
      expect(ApplicationRecord.superclass).to eq(ActiveRecord::Base)
    end
  end

  describe 'abstract class' do
    it 'is marked as abstract' do
      expect(ApplicationRecord.abstract_class?).to be true
    end
  end
end
