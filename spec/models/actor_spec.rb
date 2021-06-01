require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it {should have_many :castings}
    it {should have_many(:movies).through(:castings)}
  end
end
