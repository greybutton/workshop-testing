require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = create(:article)
    @comment = create(:comment, article_id: @article.id)
  end

  test "should create comment" do
    new_comment = attributes_for(:comment)
    post article_comments_url(@article), params: { comment: new_comment }
    assert_response :redirect
    comment = Comment.find_by(commenter: new_comment[:commenter])
    assert { @article == comment.article }
  end

  test "should get edit" do
    get edit_article_comment_url(@comment.article, @comment)
    assert_response :success
  end

  test "should update comment" do
    comment = attributes_for(:comment)
    patch article_comment_url(@article, @comment), params: { comment: { body: comment[:body], commenter: comment[:commenter] } }
    assert_response :redirect
    @comment.reload
    assert { comment[:commenter] == @comment.commenter }
    assert { comment[:body] == @comment.body }
  end

  test "should destroy comment" do
    delete article_comment_url(@article, @comment)
    assert_response :redirect
    assert { !Comment.exists?(@comment.id) }
  end
end
