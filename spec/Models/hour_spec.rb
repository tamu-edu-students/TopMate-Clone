# spec/models/hour_spec.rb

require 'rails_helper'

RSpec.describe Hour, type: :model do
  it 'is valid with valid attributes' do
    user = create(:user) # 使用 FactoryBot 创建用户对象
    hour = Hour.new(
      user: user,
      day: 1,             # 替换为有效的 day 值
      start_time: '09:00', # 替换为有效的 start time
      end_time: '17:00'    # 替换为有效的 end time
    )
    expect(hour).to be_valid
  end

  it 'is not valid without a user' do
    hour = Hour.new(
      day: 1,             # 替换为有效的 day 值
      start_time: '09:00', # 替换为有效的 start time
      end_time: '17:00'    # 替换为有效的 end time
    )
    expect(hour).not_to be_valid
  end

  it 'is not valid with an invalid day' do
    user = create(:user)
    hour = Hour.new(
      user: user,
      day: 7,             # An invalid day value
      start_time: '09:00', # 替换为有效的 start time
      end_time: '17:00'    # 替换为有效的 end time
    )
    expect(hour).not_to be_valid
  end

  it 'is not valid without a start_time' do
    user = create(:user)
    hour = Hour.new(
      user: user,
      day: 1,             # 替换为有效的 day 值
      end_time: '17:00'    # 替换为有效的 end time
    )
    expect(hour).not_to be_valid
  end

  it 'is not valid with an end_time earlier than start_time' do
    user = create(:user)
    hour = Hour.new(
      user: user,
      day: 1,             # 替换为有效的 day 值
      start_time: '17:00', # 替换为有效的 start time
      end_time: '09:00'    # End time earlier than start time
    )
    expect(hour).not_to be_valid
  end
end
