defmodule EventsWeb.HappeningController do
  use EventsWeb, :controller

  alias Events.Happenings
  alias Events.Happenings.Happening
  plug EventsWeb.Plugs.RequireUser when action
    not in [:index, :show]

  plug :fetch_happening when action
    in [:show, :edit, :update, :delete]

  plug :require_owner when action
    in [:edit, :update, :delete]

  def fetch_happening(conn, _args) do
    id = conn.params["id"]
     happening = Happenings.get_happening!(id)
     assign(conn, :happening, happening)
  end

  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    happening = conn.assigns[:happening]
    if user.id == happening.user_id do
      conn 
    else
      conn
      |> put_flash(:error, "This happening does not belong to you.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    happenings = Happenings.list_happenings()
    render(conn, "index.html", happenings: happenings)
  end

  def new(conn, _params) do
    changeset = Happenings.change_happening(%Happening{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"happening" => happening_params}) do
    happening_params = happening_params
    |> Map.put("user_id", conn.assigns[:current_user].id)
    case Happenings.create_happening(happening_params) do
      {:ok, happening} ->
        conn
        |> put_flash(:info, "Happening created successfully.")
        |> redirect(to: Routes.happening_path(conn, :show, happening))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    happening = conn.assigns[:happening]
    |> Happenings.load_comments()
    comm = %Events.Comments.Comment{
      happening_id: happening.id,
      user_id: current_user_id(conn)
    }
    new_comment = Events.Comments.change_comment(comm)
    render(conn, "show.html", 
      happening: happening, new_comment: new_comment)
  end

  def edit(conn, %{"id" => id}) do
    happening = conn.assigns[:happening]
    changeset = Happenings.change_happening(happening)
    render(conn, "edit.html", happening: happening, changeset: changeset)
  end

  def update(conn, %{"id" => id, "happening" => happening_params}) do
    happening = conn.assigns[:happening]

    case Happenings.update_happening(happening, happening_params) do
      {:ok, happening} ->
        conn
        |> put_flash(:info, "Happening updated successfully.")
        |> redirect(to: Routes.happening_path(conn, :show, happening))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", happening: happening, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    happening = conn.assigns[:happening]
    {:ok, _happening} = Happenings.delete_happening(happening)

    conn
    |> put_flash(:info, "Happening deleted successfully.")
    |> redirect(to: Routes.happening_path(conn, :index))
  end
end
