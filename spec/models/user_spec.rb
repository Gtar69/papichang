require 'spec_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:full_name)}
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:cart_items)}
end
