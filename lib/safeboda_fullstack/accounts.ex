defmodule SafebodaFullstack.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias SafebodaFullstack.Repo

  alias SafebodaFullstack.Accounts.{User, Driver, Passenger}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # def create_user(attrs \\ %{}) do
  #   %User{}
  #   |> User.changeset(attrs)
  #   |> Repo.insert()
  # end

  def create_user(attrs = %{"user_type" => "driver"}) do
    {:ok, driver} =
      Repo.transaction(fn ->
        user =
          %User{}
          |> User.changeset(attrs)
          |> Repo.insert!()

        driver = Ecto.build_assoc(user, :drivers, %{"user_id" => user.id, "suspended" => false})
        Repo.insert!(driver)
      end)

    get_driver(driver.id)
  end

  def get_driver(driver_id) do
    Repo.one!(
      from d in Driver,
        where: d.id == ^driver_id,
        join: u in User,
        on: d.user_id == u.id,
        select: %{
          id: u.id,
          suspended: d.suspended,
          first_name: u.first_name,
          last_name: u.last_name,
          phone_number: u.phone_number
        }
    )
  end

  def suspend_driver(driver_id) do
    driver = Repo.get_by!(Driver, user_id: driver_id)
    change_driver = Ecto.Changeset.change(driver, %{suspended: true})

    resp =
      case(Repo.update(change_driver)) do
        {:ok, _struct} -> 204
        {:error, _changeset_error} -> 400
      end

    resp
  end

  def unsuspend_driver(driver_id) do
    driver = Repo.get_by!(Driver, user_id: driver_id)
    change_driver = Ecto.Changeset.change(driver, %{suspended: false})

    resp =
      case Repo.update(change_driver) do
        {:ok, _struct} -> 204
        {:error, _changeset_error} -> 400
      end

    resp
  end

  def create_user(attrs = %{"user_type" => "passenger"}) do
    {:ok, passenger} =
      Repo.transaction(fn ->
        user =
          %User{}
          |> User.changeset(attrs)
          |> Repo.insert!()

        passenger = Ecto.build_assoc(user, :passengers, %{"user_id" => user.id})
        Repo.insert!(passenger)
      end)

    get_passenger(passenger.id)
  end

  def get_passenger(passenger_id) do
    Repo.one(
      from p in Passenger,
        where: p.id == ^passenger_id,
        join: u in User,
        on: p.user_id == u.id,
        select: %{
          id: u.id,
          first_name: u.first_name,
          last_name: u.last_name,
          phone_number: u.phone_number
        }
    )
  end

  # @doc """
  # Updates a user.

  # ## Examples

  #     iex> update_user(user, %{field: new_value})
  #     {:ok, %User{}}

  #     iex> update_user(user, %{field: bad_value})
  #     {:error, %Ecto.Changeset{}}

  # """
  # def update_user(%User{} = user, attrs) do
  #   user
  #   |> User.changeset(attrs)
  #   |> Repo.update()
  # end

  # @doc """
  # Deletes a user.

  # ## Examples

  #     iex> delete_user(user)
  #     {:ok, %User{}}

  #     iex> delete_user(user)
  #     {:error, %Ecto.Changeset{}}

  # """
  # def delete_user(%User{} = user) do
  #   Repo.delete(user)
  # end

  # @doc """
  # Returns an `%Ecto.Changeset{}` for tracking user changes.

  # ## Examples

  #     iex> change_user(user)
  #     %Ecto.Changeset{data: %User{}}

  # """
  # def change_user(%User{} = user, attrs \\ %{}) do
  #   User.changeset(user, attrs)
  # end
end
