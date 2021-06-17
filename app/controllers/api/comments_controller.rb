class Api::CommentsController < ApplicationController
  def create
    article = Article.find(params['article_id'])
    comment = article.comments.create(create_params.merge(user_id: current_user.id))

    binding.pry
    if comment.persisted?
      render json: { message: 'Successfully posted your comment' }, status: 201
    else
      render json: { error_message: 'Comment cannot be empty.' }, status: 422
    end
  end

  private

  def create_params
    params.require(:comment).permit(:body)
  end
end
