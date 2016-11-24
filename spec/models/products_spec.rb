require 'rails_helper'

RSpec.describe Product, type: :model do

	let(:user) { FactoryGirl.create(:user) }
	before { @product = user.products.build(image: File.new("app/assets/images/imag.jpg")) }
	subject { @product }
	it { should validate_presence_of(:nombre) }
	it { should validate_presence_of(:cantidad) }
	it { should validate_presence_of(:calorias) }
	it { should validate_presence_of(:codigo) }
	it { should have_attached_file(:image) }
	it { should validate_attachment_presence(:image) }
end