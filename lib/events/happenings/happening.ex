defmodule Events.Happenings.Happening do
  use Ecto.Schema
  import Ecto.Changeset

  schema "happenings" do
    field :date, :naive_datetime
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(happening, attrs) do
    happening
    |> cast(attrs, [:name, :date, :description])
    |> validate_required([:name, :date, :description])
  end
end
