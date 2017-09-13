defmodule MySite.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :string
      add :read_time, :integer

      timestamps()
    end

  end
end
