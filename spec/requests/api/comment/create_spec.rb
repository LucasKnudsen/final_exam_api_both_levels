RSpec.describe 'POST /api/articles/:id/comments', type: :request do
  let(:article) { create(:article) }

  describe 'Successfully' do
    before do
      post "/api/articles/#{article.id}/comments", 
        params: {
          body: 'I truly like this article!'
        }
    end

    it 'is expected to return a 201 status code' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return a success message' do
      expect(response_json['message']).to eq 'Successfully posted your comment'
    end

    it 'is expected to have created a new comment' do
      expect(Comment.all.count).to eq 1
    end

    it 'is expected to attach the comment to an article' do
      expect(article.comments.first['body']).to eq 'I truly like this article!'
    end
  end
end