defmodule PlugCodeReloader do
  @moduledoc """
  Plug that reloads code when called.
  """

  @behaviour Plug
  import Plug.Conn

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(conn, _opts) do
    PlugCodeReloader.Server.reload()
    conn
  end
end
