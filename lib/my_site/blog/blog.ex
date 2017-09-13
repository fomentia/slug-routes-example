defmodule MySite.Blog do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias MySite.Repo

  alias MySite.Blog.Post

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias MySite.Blog.Comment

  def list_comments(post), do: list_comments(post, preload: [])
  def list_comments(post, [preload: preload]) do
    Repo.all(from c in Comment, where: c.post_id == ^post, preload: ^preload)
  end

  def get_comment!(id), do: get_comment!(id, preload: [])
  def get_comment!(id, [preload: preload]) do
    Repo.get!(Comment, id) |> Repo.preload(preload)
  end

  def create_comment(attrs \\ %{},
                     %Post{} = post \\ %Post{},
                     %Comment{} = comment \\ %Comment{}) do
    comment
    |> Comment.changeset(attrs)
    |> put_assoc(:post, post)
    |> Repo.insert()
  end

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end
end
