RSpec.describe 'POST /api/articles/:id/comments', type: :request do
  let(:article) { create(:article) }
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'Successfully' do
    before do
      post "/api/articles/#{article.id}/comments", 
        params: {
          comment: { 
            body: 'I truly like this article!'
          }
        }, headers: auth_headers
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

    it 'is expected to have been written by a user' do
      expect(article.comments.first.user['email']).to eq user.email
    end
  end

  describe 'Unsuccessfully' do
    context 'with an empty body' do
      before do
        post "/api/articles/#{article.id}/comments", 
          params: {
            comment: { 
              body: ''
            }
          }, headers: auth_headers
      end

      it 'is expected to return a 422 status' do
        expect(response).to have_http_status 422
      end

      it 'is expected to return an eror message' do
        expect(response_json['error_message']).to eq 'Comment cannot be empty.'
      end
    end

    context 'as an unauthenticated visitor' do
      before do
        post "/api/articles/#{article.id}/comments", 
          params: {
            comment: { 
              body: 'I would like to comment even though I am not logged in..'
            }
          }, headers: 'wrong headers'
      end

      it 'is expected to return a 401 status' do
        expect(response).to have_http_status 401
      end

      it 'is expected to return an eror message' do
        binding.pry
        expect(response_json['errors'].to_sentence).to eq 'You need to sign in or something..'
      end
    end
  end
end