defmodule MySiteWeb.Visitor.CommentController do
  use MySiteWeb, :controller

  import MySiteWeb.Visitor.SlugHelper
  
  alias MySite.Blog

  plug :extract_id_from_slug

  def show(conn, _params) do
    comment = Blog.get_comment!(conn.assigns[:id])
    post = Blog.get_post!(comment.post_id)
    render(conn, "show.html", comment: comment, post: post)
  end
end
