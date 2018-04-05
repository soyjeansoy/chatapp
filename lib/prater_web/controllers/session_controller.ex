defmodule PraterWeb.SessionController do
  use PraterWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Prater.Auth.sign_in(email, password) do
      {:ok, user} ->
        conn
          |> put_session(:current_user_id, user.id)
          |> put_flash(:info, "Successfully signed in")
          |> redirect(to: room_path(conn, :index))
      {:error, _reason} ->
        conn
          |> put_flash(:error, "Invalid email or password")
          |> redirect("new.html")
    end
  end

  def delete(conn, _params) do
    conn
      |> Prater.Auth.sign_out()
      |> redirect(to: room_path(conn, :index))
  end
end