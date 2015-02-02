require 'spec_helper'

  #pending "add some examples to (or delete) #{__FILE__}"

  describe Product do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description)}
  end
