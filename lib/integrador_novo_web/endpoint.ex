defmodule IntegradorNovoWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :integrador_novo

  @session_options [
    store: :cookie,
    key: "_integrador_novo_key",
    signing_salt: "GqUdNCxw",
    same_site: "Lax"
  ]

  socket "/socket", IntegradorNovoWeb.UserSocket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket,
    websocket: true,
    longpoll: false

  plug Plug.Static,
    at: "/",
    from: :integrador_novo,
    gzip: false,
    only: IntegradorNovoWeb.static_paths()

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :integrador_novo
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session, @session_options

  plug IntegradorNovoWeb.Router
end
