defmodule MySiteWeb.Router do
  use MySiteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MySiteWeb.Visitor do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/posts", PostController, :index
    get "/posts/:slug", PostController, :show
    get "/comments/:slug", CommentController, :show
  end

  scope "/admin", MySiteWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/posts", PostController do
      resources "/comments", CommentController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", MySiteWeb do
  #   pipe_through :api
  # end
end
