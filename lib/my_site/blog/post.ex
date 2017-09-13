defmodule MySite.Blog.Post do
  use Ecto.Schema

  import Ecto.Changeset

  alias MySite.Blog.Post
  alias MySite.Blog.Comment

  schema "posts" do
    field :body, :string
    field :read_time, :integer
    field :title, :string
    has_many :comments, Comment, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body, :read_time])
    |> validate_required([:title, :body, :read_time])
  end
end
