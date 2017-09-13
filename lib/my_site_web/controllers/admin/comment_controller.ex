defmodule MySiteWeb.Admin.CommentController do
  use MySiteWeb, :controller

  alias MySite.Blog
  alias MySite.Blog.Comment

  def index(conn, %{"post_id" => post}) do
    comments = Blog.list_comments(post)
    render(conn, "index.html", post_id: post, comments: comments)
  end

  def new(conn, %{"post_id" => post}) do
    changeset = Blog.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset, post_id: post)
  end

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post = Blog.get_post!(post_id)

    case Blog.create_comment(comment_params, post) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: admin_post_comment_path(conn, :show, post_id, comment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    changeset = Blog.change_comment(comment)

    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Blog.get_comment!(id)

    case Blog.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: admin_post_comment_path(conn, :show, comment.post_id, comment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    {:ok, _comment} = Blog.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: admin_post_comment_path(conn, :index, comment.post_id))
  end
end
