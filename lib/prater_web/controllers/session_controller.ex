defmodule PraterWeb.SessionController do
  use PraterWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, _params) do
  end
end