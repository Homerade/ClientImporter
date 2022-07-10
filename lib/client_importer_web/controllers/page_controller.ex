defmodule ClientImporterWeb.PageController do
  use ClientImporterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
