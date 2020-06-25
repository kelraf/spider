defmodule SpiderWeb.ExportZoneBundlerController do
  use SpiderWeb, :controller

  alias Spider.ExportZoneBundlers
  alias Spider.ExportZoneBundlers.ExportZoneBundler

  alias Spider.Repo

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    export_zone_bundler = ExportZoneBundlers.list_export_zone_bundler()
    render(
      conn, 
      "index.json", 
      export_zone_bundler: export_zone_bundler
      |> Repo.preload([
          business: [
            :business_assets, 
            :user
          ],
          export_zone_livestock_orders: [
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ]
      )
    )
  end

  def get_by_business_id(conn, %{"business_id" => business_id}) do

    render(
      conn, 
      "show.json", 
      export_zone_bundler: 
        Repo.get_by!(ExportZoneBundler, business_id: business_id)
        |> Repo.preload([
          business: [
            :business_assets, 
            :user
          ],
          export_zone_livestock_orders: [
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ]
      )
      
    )

  end

  def create(conn, %{"export_zone_bundler" => export_zone_bundler_params}) do
    with {:ok, %ExportZoneBundler{} = export_zone_bundler} <- ExportZoneBundlers.create_export_zone_bundler(export_zone_bundler_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", export_zone_bundler_path(conn, :show, export_zone_bundler))
      |> render(
        "show.json", 
        export_zone_bundler: export_zone_bundler 
        |> Repo.preload([
            business: [
              :business_assets, 
              :user
            ],
            export_zone_livestock_orders: [
              livestock_order: [
                d_livestock: [
                  d_livestock_images: []
                ]
              ]
            ]
          ]
        )
      )
    end
  end

  def show(conn, %{"id" => id}) do
    export_zone_bundler = ExportZoneBundlers.get_export_zone_bundler!(id)
    render(
      conn, 
      "show.json", 
      export_zone_bundler: export_zone_bundler
      |> Repo.preload([
          business: [
            :business_assets, 
            :user
          ],
          export_zone_livestock_orders: [
            livestock_order: [
              d_livestock: [
                d_livestock_images: []
              ]
            ]
          ]
        ]
      )
    )
  end

  def update(conn, %{"id" => id, "export_zone_bundler" => export_zone_bundler_params}) do
    export_zone_bundler = ExportZoneBundlers.get_export_zone_bundler!(id)

    with {:ok, %ExportZoneBundler{} = export_zone_bundler} <- ExportZoneBundlers.update_export_zone_bundler(export_zone_bundler, export_zone_bundler_params) do
      render(
        conn, 
        "show.json", 
        export_zone_bundler: export_zone_bundler
        |> Repo.preload([
            business: [
              :business_assets, 
              :user
            ],
            export_zone_livestock_orders: [
              livestock_order: [
                d_livestock: [
                  d_livestock_images: []
                ]
              ]
            ]
          ]
        )
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    export_zone_bundler = ExportZoneBundlers.get_export_zone_bundler!(id)
    with {:ok, %ExportZoneBundler{}} <- ExportZoneBundlers.delete_export_zone_bundler(export_zone_bundler) do
      send_resp(conn, :no_content, "")
    end
  end
end
