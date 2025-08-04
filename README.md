# PlugCodeReloader

**TODO: Add description**

## Installation

The package can be installed
by adding `plug_code_reloader` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:plug_code_reloader, "~> 0.1.0", only: :dev}
  ]
end
```

Documentation can be found at <https://hexdocs.pm/plug_code_reloader>.

## Usage

On your routes file

```elixir
plug(PlugCodeReloader)
```

On your `application.ex`

```elixir
children = [
  # Code reloading must be serial across all Phoenix apps
  PlugCodeReloader.Server,
]
```

## Limitations

If you have a big route file that includes all implementations of the API resources, the code is only gonna be reloaded the next request, not the first, but if you forward your request to another plug and it will work

```elixir
defmodule MyApp.Router do
  use Plug.Router

  if Mix.env() == :dev do
    plug(PlugCodeReloader)
    plug(Plug.Logger)
  end

  plug(:match)
  plug(:dispatch)

  # will reload on the first request
  forward("/foo", to: MyApp.Foo)
  match("/bar", to: MyApp.Bar)

  # will reload on the second request
  get("/foobar") do
    send_resp(conn, 200, "")
  end

end
```

## TODO

1. see if there is a way to fix the request problem that makes the API be called twice for the same effect
2. improve it with an IO proxy
3. backup files when errors occour
