defmodule Rental.Guardian do
    use Guardian, otp_app: :rental
    alias Rental.Accounts.User
    alias Rental.Repo

    def subject_for_token(resource, _claims) do
        sub = to_string(resource.id)
        {:ok, sub}
    end

    def subject_for_token(_, _) do
        {:error, "No Resource Provided"}
    end

    def resource_from_claims(claims) do
        id = claims["sub"]
        resource = Repo.get(User, id)
        {:ok, resource}
    end

    def resource_from_claims(_claims) do
        {:error, "Invalid Claims"}
    end
end
