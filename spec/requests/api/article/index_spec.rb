RSpec.describe 'GET /api/articles', type: :request do
  let!(:articles) { 3.times { create(:article) } }
  let(:article_with_comments) { create(:article) }
  let!(:comments) { 3.times { create(:comment, article_id: article_with_comments.id) } }
  describe 'successfully' do
    before do
      get '/api/articles'
    end

    it 'is expected to return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return four articles' do
      expect(response_json['articles'].count).to eq 4
    end

    it 'is expected to include associated comments' do
      binding.pry
      expect(response_json['articles'].last['comments'].count).to eq 3
    end
  end
end