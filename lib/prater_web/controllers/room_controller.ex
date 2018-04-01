defmodule PraterWeb.RoomController do
  use PraterWeb, :controller
  alias Prater.Conversation
  alias Prater.Conversation.Room

  def index(conn, _params) do
    rooms = Conversation.list_rooms()
    render conn, "index.html", rooms: rooms
  end

  def new(conn, _params) do
    #changeset = Room.changeset(%Room{}, %{})
    changeset = Conversation.change_room(%Room{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"room" => room_params}) do
    case Conversation.create_room(room_params) do 
      {:ok, room} ->
        conn
          |> put_flash(:info, "Created successfully.")
          |> redirect(to: room_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    render conn, "show.html", room: room
  end

  def edit(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    changeset = Conversation.change_room(room)
    render conn, "edit.html", room: room, changeset: changeset
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Conversation.get_room!(id)

    case Conversation.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Updated successfully.")
        |> redirect(to: room_path(conn, :show, room))
      
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "edit.html", room: room, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    {:ok, room} = Conversation.delete_room(room)

    conn
      |> put_flash(:info, "Deleted successfully.")
      |> redirect(to: room_path(conn, :index))
  end
end