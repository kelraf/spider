# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Spider.Repo.insert!(%Spider.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do 

    alias Spider.Accounts
    alias Spider.Businesses
    alias Spider.DLivestocks

    defp create_server_admin_user() do

        Accounts.create_user(%{
            "phone_number" => "0778259281",
            "first_name" => "Spider Server",
            "last_name" => "Spider Server",
            "role" => "spider-server-admin",
            "status" => 1,
            "raw_password" => "spiderserver",
            "confirm_password" => "spiderserver"
        })

    end

    defp create_server_admin_business(user) do

        case user do
            {:error, error} ->

                IO.inspect %{
                    message: "An Error Occured When Creating Server Admin User",
                    error: error
                }

            {:ok, user} ->

                IO.inspect %{
                    message: "Server Admin User Created Successfully",
                    data: user
                }

                business = Businesses.create_business(%{
                    "business_name" => "server",
                    "registration_number" => "888888",
                    "business_type" => "server",
                    "category" => "server",
                    "sub_category" => "server",
                    "user_id" => user.id
                })

                case business do

                    {:error, error} ->

                        IO.inspect %{
                            message: "An Error Occured When Creating Server Admin Business",
                            error: error
                        }
        
                    {:ok, business} ->
        
                        IO.inspect %{
                            message: "Server Admin Business Created Successfully",
                            data: business
                        }
                    
                end
                
        end
    end

    defp create_super_instance_admin() do

        Accounts.create_user(%{
            "phone_number" => "0794665127",
            "first_name" => "Spider Super Instance Admin",
            "last_name" => "Spider Super Instance Admin",
            "role" => "spider-super-instance-admin",
            "status" => 1,
            "raw_password" => "spider",
            "confirm_password" => "spider"
        })

    end

    defp create_super_instance_admin_business(user) do

        case user do
            {:error, error} ->

                IO.inspect %{
                    message: "An Error Occured When Creating Super Instance Admin User",
                    error: error
                }

            {:ok, user} ->

                IO.inspect %{
                    message: "Super Instance Admin User Created Successfully",
                    data: user
                }

                business = Businesses.create_business(%{
                    "business_name" => "super instance",
                    "registration_number" => "55555",
                    "business_type" => "spider-super-instance",
                    "category" => "spider-super-instance",
                    "sub_category" => "spider-super-instance",
                    "user_id" => user.id
                })

                case business do

                    {:error, error} ->

                        IO.inspect %{
                            message: "An Error Occured When Creating Super Instance Admin Business",
                            error: error
                        }
        
                    {:ok, business} ->
        
                        IO.inspect %{
                            message: "Super Instance Admin Business Created Successfully",
                            data: business
                        }
                    
                end
                
        end

    end

    def create_d_livestocks() do

        d_livestocks = [
            %{
                category: "Cattle",
                type: "Cow",
                d_livestock_slaughter_outputs: [
                    %{
                        output_name: "Cow Meat",
                        units: "kgs",
                        checked: true
                    },
                    %{
                        output_name: "Cow Legs",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another One",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Two",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Three",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Four",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Five",
                        units: "No Units"
                    }
                ]
            },
            %{
                category: "Cattle",
                type: "Sheep",
                d_livestock_slaughter_outputs: [
                    %{
                        output_name: "Sheep Meat",
                        units: "kgs",
                        checked: true
                    },
                    %{
                        output_name: "Sheep Legs",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another One",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Two",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Three",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Four",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Five",
                        units: "No Units"
                    }
                ]
            },
            %{
                category: "Cattle",
                type: "Goat",
                d_livestock_slaughter_outputs: [
                    %{
                        output_name: "Goat Meat",
                        units: "kgs",
                        checked: true
                    },
                    %{
                        output_name: "Goat Legs",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another One",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Two",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Three",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Four",
                        units: "No Units"
                    },
                    %{
                        output_name: "Another Five",
                        units: "No Units"
                    }
                ]
            }
        ]

        Enum.each(d_livestocks, fn d_livestock -> 

            DLivestocks.create_d_livestock d_livestock
        
        end)
        
    end

    def run() do

        create_server_admin_user() |> create_server_admin_business()
        create_super_instance_admin() |> create_super_instance_admin_business()
        create_d_livestocks()
        
    end

end

Seeds.run()