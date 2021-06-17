RSpec.describe Comment, type: :model do
  describe 'DB tables' do
    it { is_expected.to have_db_column(:body).of_type(:text) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :article }
    it { is_expected.to belong_to :user }
  end

  describe "Factory" do
    it "is expected to have valid Factory" do
      expect(create(:comment)).to be_valid
    end
  end
end
