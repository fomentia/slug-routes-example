defmodule MySite.Blog.Comment do
  use Ecto.Schema

  import Ecto.Changeset

  alias MySite.Blog.Post
  alias MySite.Blog.Comment

  schema "comments" do
    field :author_name, :string
    field :body, :string
    field :title, :string
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:body, :author_name, :title])
    |> validate_required([:body, :author_name])
  end
end
