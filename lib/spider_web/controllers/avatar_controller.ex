defmodule SpiderWeb.AvatarController do
  use SpiderWeb, :controller

  alias Spider.Avatars
  alias Spider.Avatars.Avatar

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    avatars = Avatars.list_avatars()
    render(conn, "index.json", avatars: avatars)
  end

  def create(conn, %{"avatar" => avatar_params, "user_id" => user_id}) do

    [head | _ ] = avatar_params

    with {:ok, %Avatar{} = avatar} <- Avatars.create_avatar(%{avatar: head, user_id: user_id}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", avatar_path(conn, :show, avatar))
      |> render("show.json", avatar: avatar)
    end

  end

  def show(conn, %{"id" => id}) do
    avatar = Avatars.get_avatar!(id)
    render(conn, "show.json", avatar: avatar)
  end

  def update(conn, %{"id" => id, "avatar" => avatar_params}) do
    
    avatar = Avatars.get_avatar!(id)

    attachment = avatar

    path = Spider.Avatar.url({attachment.avatar, attachment}) |> String.split("?") |> List.first

    # Task.start(fn -> 
    Spider.Avatar.delete({path, attachment})
    # end)

    [head | _] = avatar_params

    with {:ok, %Avatar{} = avatar} <- Avatars.update_avatar(avatar, %{avatar: head}) do
      render(conn, "show.json", avatar: avatar)
    end

  end

  def delete(conn, %{"id" => id}) do

    avatar = Avatars.get_avatar!(id)

    attachment = avatar

    path = 
      Spider.Avatar.url({attachment.avatar, attachment}) 
      |> String.split("?") 
      |> List.first

    Task.start(fn -> 
      Spider.Avatar.delete({path, attachment})
    end)

    with {:ok, %Avatar{}} <- Avatars.delete_avatar(avatar) do
      send_resp(conn, :no_content, "")
    end

  end

end
