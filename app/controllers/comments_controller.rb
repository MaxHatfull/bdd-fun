class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @comment = Comment.new(comment_params)
    @comment.save!

    respond_to do |format|
      format.html do
        redirect_to post_url(@comment.post), notice: "Comment was successfully created."
      end
      format.turbo_stream
    end
  end

  def destroy
    Comment.find(params[:id]).destroy!

    redirect_to post_url(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end
end