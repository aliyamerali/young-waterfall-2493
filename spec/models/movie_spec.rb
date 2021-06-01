require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :castings}
    it {should have_many(:actors).through(:castings)}
  end
end
