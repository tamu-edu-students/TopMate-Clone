# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ServicesHelper. For example:
#
# describe ServicesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ServicesHelper, type: :helper do
    describe '#user_availability_for_day' do
        it 'returns users availability for a given day' do
        end

        it 'returns nil if user is nil' do
        end
    end

    describe '#get_day_of_week_int' do
        it 'returns the integer value of the day of the week' do
        end

        it 'returns the correct value for all days of the week' do
        end
    end

    describe '#remove_appts_from_hours' do
        it 'splits availability when appointment is in the middle' do
        end

        it 'removes availability when appointment is at the beginning' do
        end

        it 'availability does not change when appointment does not overlap' do
        end
    end
end
