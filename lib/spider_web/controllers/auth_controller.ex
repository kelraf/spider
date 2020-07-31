defmodule SpiderWeb.AuthController do
  use SpiderWeb, :controller

  alias Spider.Auth
  alias Spider.Guardian
  alias Spider.Repo

  action_fallback(SpiderWeb.FallbackController)

  def login(conn, %{"user_credentials" => user_credentials}) do
    case Auth.login(user_credentials) do
      {:error, message} ->
        conn
        |> json(%{
          message: message,
          status: "auth_error"
        })

      {:not_verified, message} ->
        conn
        |> json(%{
          message: message,
          status: "not_verified"
        })

      {:ok, user_data_to_encode, user} ->
        case Guardian.encode_and_sign(user_data_to_encode) do
          {:ok, token, _claims} ->
            user =
              user
              |> Repo.preload(
                avatar: [],
                business: [
                  business_assets: []
                ]
              )
              |> processUser()
              |> processBusiness()
              |> processBusinessAssets()
              |> processAvatar()

            conn
            |> json(%{
              status: "success",
              token: token,
              data: user
            })

          {:error, _reason} ->
            conn
            |> json(%{
              status: "gen_token_error",
              error: "Oops Something went wrong. Please Try Again"
            })
        end
    end
  end

  defp processBusiness(user) do
    case Map.get(user, :business) do
      nil ->
        user

      business ->
        business =
          business
          |> Map.from_struct()
          |> Map.drop([:__meta__, :user])

        Map.put(user, :business, business)
    end
  end

  defp processBusinessAssets(user) do
    case Map.get(user, :business) do
      nil ->
        user

      business ->
        case Map.get(business, :business_assets) do
          nil ->
            business

          business_assets ->
            business_assets_ =
              Enum.map(business_assets, fn business_asset ->
                business_asset
                |> Map.from_struct()
                |> Map.drop([:__meta__, :business])
              end)

            business = Map.put(business, :business_assets, business_assets_)
            Map.put(user, :business, business)
        end
    end
  end

  defp processUser(user) do
    user
    |> Map.from_struct()
    |> Map.drop([:__meta__])
  end

  defp processAvatar(user) do

    case Map.get(user, :avatar) do
      nil ->
        user

      avatar ->
        avatar =
          avatar
          |> Map.from_struct()
          |> Map.drop([:__meta__, :user])

        Map.put(user, :avatar, avatar)
    end
    
  end
end
