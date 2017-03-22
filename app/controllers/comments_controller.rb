class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = session[:user_id]
    if @comment.save
      redirect_to :back
    else
      flash[:notice] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  protected
    def comment_params
      params.require(:comment).permit(:content, :event_id)
    end
end
