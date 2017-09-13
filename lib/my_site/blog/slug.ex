defmodule MySite.Blog.Slug do
  defstruct [:resource]

  defimpl Phoenix.Param, for: MySite.Blog.Slug do
    def to_param(slug) do
      "#{slug.resource.id}-" <> (slug.resource.title
      |> String.downcase
      |> String.strip
      |> String.replace(~r/[ :]/, "-")
      |> String.replace(~r/[^A-Za-z0-9-]/, "")
      |> String.replace(~r/-+/, "-"))
      |> String.trim_trailing("-")
    end
  end
end
