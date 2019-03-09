require 'test_helper'

class ArticleFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "can see articles" do
    get "/articles"
    assert_select '[data-test="articles-title"]', "Articles"
    assert_select "tr", 3
  end

  test "can create an article" do
    get "/articles/new"
    assert_response :success
   
    post "/articles",
      params: { article: { title: "can create", body: "article successfully." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select '[data-test="article-page-title"]', "Title:\n  can create"
    assert_select '[data-test="article-page-body"]', "Body:\n  article successfully."
  end

  test "can update an article" do
    get "/articles/#{@article.id}/edit"
    assert_response :success
    patch "/articles/#{@article.id}",
      params: { article: { title: "can update", body: "article successfully." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select '[data-test="article-page-title"]', "Title:\n  can update"
    assert_select '[data-test="article-page-body"]', "Body:\n  article successfully."
  end

  test "can see an article" do
    get "/articles/#{@article.id}"
    assert_select '[data-test="article-page-title"]', "Title:\n  #{@article.title}"
    assert_select '[data-test="article-page-body"]', "Body:\n  #{@article.body}"
  end

  test "can delete an article" do
    delete "/articles/#{@article.id}"
    get "/articles"
    assert_select '[data-test="articles-title"]', "Articles"
    assert_select "tr", 2
  end
end
