defmodule MySite.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :author_name, :string
      add :title, :string, default: "New Comment"
      add :post_id, references(:posts)

      timestamps()
    end

  end
end
