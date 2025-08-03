defmodule PlugCodeReloader.Server do
  @moduledoc """
  GenServer that handles code reloading.
  """
  use GenServer

  require Logger

  def reload do
    case Process.whereis(PlugCodeReloader.Server) do
      nil ->
        Logger.error("PlugCodeReloader.Server is not running, cannot reload code.")
        :error

      _pid ->
        GenServer.call(PlugCodeReloader.Server, {:reload, %{timestamp: System.os_time()}}, :infinity)
    end
  end

  def start_link(_) do
    case Code.ensure_loaded(Mix.Task) do
      {:module, Mix.Task} ->
        GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

      _ ->
        Logger.warn("Mix.Task not available, code reloading will not work")
        :ignore
    end
  end

  def init(_) do
    {:ok, %{timestamp: System.os_time()}}
  end

  def handle_call({:reload, %{timestamp: call_timestamp}}, _, %{timestamp: state_timestamp}) do
    if should_reload?(call_timestamp, state_timestamp) do
      do_reload()
    end

    {:reply, :ok, %{timestamp: System.os_time()}}
  end

  defp should_reload?(timestamp, state_timestamp) do
    timestamp > state_timestamp
  end

  @compile_args ["--no-all-warnings"]

  defp do_reload do
    Mix.compilers()
    |> Enum.each(fn compiler ->
      Mix.Task.reenable("compile.#{compiler}")
      Mix.Task.run("compile.#{compiler}", @compile_args)
    end)
  end
end
