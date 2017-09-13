defmodule MySite.BlogTest do
  use MySite.DataCase

  alias MySite.Blog

  describe "posts" do
    alias MySite.Blog.Post

    @valid_attrs %{body: "some body", read_time: 42, title: "some title"}
    @update_attrs %{body: "some updated body", read_time: 43, title: "some updated title"}
    @invalid_attrs %{body: nil, read_time: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.read_time == 42
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Blog.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.body == "some updated body"
      assert post.read_time == 43
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "comments" do
    alias MySite.Blog.Comment

    @valid_attrs %{author_name: "some author_name", body: "some body", title: "some title"}
    @update_attrs %{author_name: "some updated author_name", body: "some updated body", title: "some updated title"}
    @invalid_attrs %{author_name: nil, body: nil, title: nil}

    def comment_fixture(attrs \\ %{}) do
      associated_post = post_fixture()
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_comment(associated_post)

      {comment, associated_post}
    end

    test "list_comments/0 returns all comments" do
      {comment, associated_post} = comment_fixture()
      assert Blog.list_comments(associated_post.id, preload: [:post]) == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      {comment, _post} = comment_fixture()
      assert Blog.get_comment!(comment.id, preload: [:post]) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Blog.create_comment(@valid_attrs)
      assert comment.author_name == "some author_name"
      assert comment.body == "some body"
      assert comment.title == "some title"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      {comment, _post} = comment_fixture()
      assert {:ok, comment} = Blog.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.author_name == "some updated author_name"
      assert comment.body == "some updated body"
      assert comment.title == "some updated title"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      {comment, _post} = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_comment(comment, @invalid_attrs)
      assert comment == Blog.get_comment!(comment.id, preload: [:post])
    end

    test "delete_comment/1 deletes the comment" do
      {comment, _post} = comment_fixture()
      assert {:ok, %Comment{}} = Blog.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      {comment, _post} = comment_fixture()
      assert %Ecto.Changeset{} = Blog.change_comment(comment)
    end
  end
end
