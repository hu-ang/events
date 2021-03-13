defmodule Events.Happenings.Happening do
  use Ecto.Schema
  import Ecto.Changeset

  schema "happenings" do
    field :date, :naive_datetime
    field :description, :string
    field :name, :string
    belongs_to :user, Events.Users.User
    has_many :comments, Events.Comments.Comment
    #means field user_id contains id for user

    timestamps()
  end

  @doc false
  def changeset(happening, attrs) do
    happening
    |> cast(attrs, [:name, :date, :description, :user_id])
    |> validate_required([:name, :date, :description, :user_id])
  end
end
