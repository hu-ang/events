defmodule Events.HappeningsTest do
  use Events.DataCase

  alias Events.Happenings

  describe "happenings" do
    alias Events.Happenings.Happening

    @valid_attrs %{date: ~N[2010-04-17 14:00:00], description: "some description", name: "some name"}
    @update_attrs %{date: ~N[2011-05-18 15:01:01], description: "some updated description", name: "some updated name"}
    @invalid_attrs %{date: nil, description: nil, name: nil}

    def happening_fixture(attrs \\ %{}) do
      {:ok, happening} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Happenings.create_happening()

      happening
    end

    test "list_happenings/0 returns all happenings" do
      happening = happening_fixture()
      assert Happenings.list_happenings() == [happening]
    end

    test "get_happening!/1 returns the happening with given id" do
      happening = happening_fixture()
      assert Happenings.get_happening!(happening.id) == happening
    end

    test "create_happening/1 with valid data creates a happening" do
      assert {:ok, %Happening{} = happening} = Happenings.create_happening(@valid_attrs)
      assert happening.date == ~N[2010-04-17 14:00:00]
      assert happening.description == "some description"
      assert happening.name == "some name"
    end

    test "create_happening/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Happenings.create_happening(@invalid_attrs)
    end

    test "update_happening/2 with valid data updates the happening" do
      happening = happening_fixture()
      assert {:ok, %Happening{} = happening} = Happenings.update_happening(happening, @update_attrs)
      assert happening.date == ~N[2011-05-18 15:01:01]
      assert happening.description == "some updated description"
      assert happening.name == "some updated name"
    end

    test "update_happening/2 with invalid data returns error changeset" do
      happening = happening_fixture()
      assert {:error, %Ecto.Changeset{}} = Happenings.update_happening(happening, @invalid_attrs)
      assert happening == Happenings.get_happening!(happening.id)
    end

    test "delete_happening/1 deletes the happening" do
      happening = happening_fixture()
      assert {:ok, %Happening{}} = Happenings.delete_happening(happening)
      assert_raise Ecto.NoResultsError, fn -> Happenings.get_happening!(happening.id) end
    end

    test "change_happening/1 returns a happening changeset" do
      happening = happening_fixture()
      assert %Ecto.Changeset{} = Happenings.change_happening(happening)
    end
  end
end
