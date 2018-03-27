defmodule Prater.Conversation do
  alias Prater.Conversation.Room
  alias Prater.Repo

  def list_rooms do
    Repo.all(Room)
  end
end