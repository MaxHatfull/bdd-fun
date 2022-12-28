class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    pp params.to_unsafe_h
    @comment.save!

    redirect_to post_url(@comment.post), notice: "Comment was successfully created."
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