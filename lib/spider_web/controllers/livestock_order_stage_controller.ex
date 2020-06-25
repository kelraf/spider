defmodule SpiderWeb.LivestockOrderStageController do
  use SpiderWeb, :controller

  alias Spider.LivestockOrderStages
  alias Spider.LivestockOrderStages.LivestockOrderStage
  alias Spider.Repo

  action_fallback(SpiderWeb.FallbackController)

  def index(conn, _params) do
    livestock_order_stages = LivestockOrderStages.list_livestock_order_stages()

    render(
      conn,
      "index.json",
      livestock_order_stages:
        livestock_order_stages
        |> Repo.preload(
          [
            center_order: [
              livestock_sales: [
                business: [
                  user: [],
                  business_assets: []
                ], 
                d_livestock: [
                  d_livestock_images: []
                ]
              ], 
              d_livestock: [
                d_livestock_images: []
              ]
            ], 
            c_c_p_l_orders: [], 
            livestock_order_processing_stages: [
              livestock_order_slaughter_order: [
                livestock_order_slaughter_order_outputs: [
                  d_livestock_slaughter_output: []
                ],
                business: [
                  business_assets: [], 
                  user: []
                ]
              ]
            ], 
            export_zone_livestock_orders: [
              export_zone_bundler: [
                business: [
                  business_assets: [], 
                  user: []
                ],
                export_zone_livestock_orders: [
                  livestock_order: [
                    d_livestock: [
                      d_livestock_images: []
                    ]
                  ]
                ]
              ]
            ]
          ]
        )
    )
  end

  def create(conn, %{"livestock_order_stage" => livestock_order_stage_params}) do
    with {:ok, %LivestockOrderStage{} = livestock_order_stage} <-
           LivestockOrderStages.create_livestock_order_stage(livestock_order_stage_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        livestock_order_stage_path(conn, :show, livestock_order_stage)
      )
      |> render("show.json",
        livestock_order_stage:
          livestock_order_stage
          |> Repo.preload(
            [
              center_order: [
                livestock_sales: [
                  business: [
                    user: [],
                    business_assets: []
                  ], 
                  d_livestock: [
                    d_livestock_images: []
                  ]
                ], 
                d_livestock: [
                  d_livestock_images: []
                ]
              ], 
              c_c_p_l_orders: [],  
              livestock_order_processing_stages: [
                livestock_order_slaughter_order: [
                  livestock_order_slaughter_order_outputs: [
                    d_livestock_slaughter_output: []
                  ],
                  business: [
                    business_assets: [], 
                    user: []
                  ]
                ]
              ], 
              export_zone_livestock_orders: [
                export_zone_bundler: [
                  business: [
                    business_assets: [], 
                    user: []
                  ],
                  export_zone_livestock_orders: [
                    livestock_order: [
                      d_livestock: [
                        d_livestock_images: []
                      ]
                    ]
                  ]
                ]
              ]
            ]
          )
      )
    end
  end

  def show(conn, %{"id" => id}) do
    livestock_order_stage = LivestockOrderStages.get_livestock_order_stage!(id)

    render(conn, "show.json",
      livestock_order_stage:
        livestock_order_stage
        |> Repo.preload(
          [
            center_order: [
              livestock_sales: [
                business: [
                  user: [],
                  business_assets: []
                ], 
                d_livestock: [
                  d_livestock_images: []
                ]
              ], 
              d_livestock: [
                d_livestock_images: []
              ]
            ], 
            c_c_p_l_orders: [],  
            livestock_order_processing_stages: [
              livestock_order_slaughter_order: [
                livestock_order_slaughter_order_outputs: [
                  d_livestock_slaughter_output: []
                ],
                business: [
                  business_assets: [], 
                  user: []
                ]
              ]
            ], 
            export_zone_livestock_orders: [
              export_zone_bundler: [
                business: [
                  business_assets: [], 
                  user: []
                ],
                export_zone_livestock_orders: [
                  livestock_order: [
                    d_livestock: [
                      d_livestock_images: []
                    ]
                  ]
                ]
              ]
            ]
          ]
        )
    )
  end

  def update(conn, %{"id" => id, "livestock_order_stage" => livestock_order_stage_params}) do
    livestock_order_stage = LivestockOrderStages.get_livestock_order_stage!(id)

    with {:ok, %LivestockOrderStage{} = livestock_order_stage} <-
           LivestockOrderStages.update_livestock_order_stage(
             livestock_order_stage,
             livestock_order_stage_params
           ) do
      render(conn, "show.json",
        livestock_order_stage:
          livestock_order_stage
          |> Repo.preload(
            [
              center_order: [
                livestock_sales: [
                  business: [
                    user: [],
                    business_assets: []
                  ], 
                  d_livestock: [
                    d_livestock_images: []
                  ]
                ], 
                d_livestock: [
                  d_livestock_images: []
                ]
              ], 
              c_c_p_l_orders: [], 
              livestock_order_processing_stages: [
                livestock_order_slaughter_order: [
                  livestock_order_slaughter_order_outputs: [
                    d_livestock_slaughter_output: []
                  ],
                  business: [
                    business_assets: [], 
                    user: []
                  ]
                ]
              ], 
              export_zone_livestock_orders: [
                export_zone_bundler: [
                  business: [
                    business_assets: [], 
                    user: []
                  ],
                  export_zone_livestock_orders: [
                    livestock_order: [
                      d_livestock: [
                        d_livestock_images: []
                      ]
                    ]
                  ]
                ]
              ]
            ]
          )
      )
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock_order_stage = LivestockOrderStages.get_livestock_order_stage!(id)

    with {:ok, %LivestockOrderStage{}} <-
           LivestockOrderStages.delete_livestock_order_stage(livestock_order_stage) do
      send_resp(conn, :no_content, "")
    end
  end
end
