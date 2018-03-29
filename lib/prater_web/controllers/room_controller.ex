defmodule PraterWeb.RoomController do
  use PraterWeb, :controller
  alias Prater.Conversation
  alias Prater.Conversation.Room
  alias Prater.Repo

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
end