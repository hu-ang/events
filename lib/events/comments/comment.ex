defmodule Events.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :happening, Events.Happenings.Happening
    belongs_to :user, Events.Users.User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :happening_id, :user_id])
    |> validate_required([:body, :user_id, :happening_id])
  end
end
