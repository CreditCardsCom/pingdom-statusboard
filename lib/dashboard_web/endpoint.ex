defmodule DashboardWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :dashboard

  socket "/socket", DashboardWeb.UserSocket

  plug Plug.Static,
    at: "/", from: :dashboard, gzip: true,
    only: ~w(fonts images css js favicon.png)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  #plug Plug.Session,
  #  store: :cookie,
  #  key: "_dashboard_key",
  #  signing_salt: "jydBM/oM"

  plug DashboardWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, put_in(config, [:http, :port], port)}
    else
      {:ok, config}
    end
  end

end
