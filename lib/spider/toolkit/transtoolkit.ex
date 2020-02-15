defmodule Spider.TranstoolKit do

    use Ecto.Schema
    import Ecto.Changeset

    def validate_role(changeset) do
        
        case get_field(changeset, :role) do
            nil -> 
                changeset
            role ->

                if role not in ["meat_transporter"] do
                    add_error(changeset, :role, "Invalid Role")
                else 
                    changeset
                end
        end

    end
end