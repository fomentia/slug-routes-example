defmodule MySiteWeb.Visitor.PostController do
  use MySiteWeb, :controller

  import MySiteWeb.Visitor.SlugHelper

  alias MySite.Blog

  plug :extract_id_from_slug when action in [:show]

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, _params) do
    post = Blog.get_post!(conn.assigns[:id])
    comments = Blog.list_comments(conn.assigns[:id])
    render(conn, "show.html", post: post, comments: comments)
  end
end
