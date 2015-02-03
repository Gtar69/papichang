require 'spec_helper'

RSpec.describe CartItem, :type => :model do
  it {should belong_to :user}
  it {should belong_to :product}
end
