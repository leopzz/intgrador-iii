defmodule IntegradorNovoWeb.Router do
  use IntegradorNovoWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {IntegradorNovoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug Pow.Plug.Session, otp_app: :integrador_novo
    # plug IntegradorNovoWeb.Plug.RequireAuthenticatedUser  # Exemplo de plug para autenticação
    plug Pow.Plug.Session, otp_app: :integrador_novo

  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: IntegradorNovoWeb.AuthErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IntegradorNovoWeb do
    pipe_through [:browser, :protected]

    get "/", PageController, :home

    live "/configuration_item", ConfigurationItemLive.Index, :index
    live "/configuration_item/new", ConfigurationItemLive.Index, :new
    live "/configuration_item/:id/edit", ConfigurationItemLive.Index, :edit

    live "/configuration_item/:id", ConfigurationItemLive.Show, :show
    live "/configuration_item/:id/show/edit", ConfigurationItemLive.Show, :edit

    # Rotas para Solution
    live "/solutions", SolutionLive.Index, :index
    live "/solutions/new", SolutionLive.Index, :new
    live "/solutions/:id/edit", SolutionLive.Index, :edit

    live "/solutions/:id", SolutionLive.Show, :show
    live "/solutions/:id/show/edit", SolutionLive.Show, :edit

    live "/events", EventLive.Index, :index
    live "/events/new", EventLive.Index, :new
    live "/events/:id/edit", EventLive.Index, :edit

    live "/events/:id", EventLive.Show, :show
    live "/events/:id/show/edit", EventLive.Show, :edit

    live "/machines", MachineLive.Index, :index
    live "/machines/new", MachineLive.Index, :new
    live "/machines/:id/edit", MachineLive.Index, :edit

    live "/machines/:id", MachineLive.Show, :show
    live "/machines/:id/show/edit", MachineLive.Show, :edit

    live "/alerts", AlertsLive.Index, :index

  end

  # lib/integrador_novo_web/router.ex

  scope "/dashboard", IntegradorNovoWeb do
    pipe_through [:browser, :protected]

    live "/", DashboardLive.Index, :index
    live "/:id", DashboardLive.Show, :show
    post "/:id/history_data", HistoryController, :history_data
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/api", IntegradorNovoWeb do
    pipe_through :api

    post "/history", HistoryController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", IntegradorNovoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:integrador_novo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: IntegradorNovoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
