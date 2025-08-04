defmodule PlugCodeReloader.ServerTest do
  use ExUnit.Case, async: true

  describe "start_link/1" do
    test "starts the server when Mix.Task is available" do
      assert {:ok, _pid} = PlugCodeReloader.Server.start_link([])
    end
  end

  describe "reload/0" do
    test "returns :error when the server is not running" do
      assert PlugCodeReloader.Server.reload() == :error
    end

    test "reloads code when the server is running" do
      pid = start_supervised!(PlugCodeReloader.Server)

      assert PlugCodeReloader.Server.reload() == :ok
      assert Process.alive?(pid)
    end
  end
end
