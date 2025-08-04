defmodule PlugCodeReloaderTest do
  use ExUnit.Case, async: true
  import Plug.Test

  defmodule MyRouter do
    use Plug.Router

    plug(PlugCodeReloader)
    plug(:match)
    plug(:dispatch)

    get "/" do
      send_resp(conn, 200, "Hello, World!")
    end
  end

  describe "init/1" do
    test "returns the options passed to it" do
      opts = [foo: :bar]
      assert PlugCodeReloader.init(opts) == opts
    end
  end

  describe "call/2" do
    test "calls the PlugCodeReloader.Server.reload/0 function" do
      conn =
        conn(:get, "/")
        |> PlugCodeReloader.call([])
        |> MyRouter.call([])

      assert conn.status == 200
      assert conn.resp_body == "Hello, World!"
    end
  end
end
