defmodule SafebodaFullstack.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias SafebodaFullstack.Repo

  alias SafebodaFullstack.Accounts.{User, Driver, Passenger}
  alias SafebodaFullstack.Ride
  alias SafebodaFullstack.Ride.OngoingRides

  # @doc """
  # Returns the list of users.

  # ## Examples

  #     iex> list_users()
  #     [%User{}, ...]

  # # """
  # # def list_users do
  #   Repo.all(User)
  # end

  # @doc """
  # Gets a single user.

  # Raises `Ecto.NoResultsError` if the User does not exist.

  # ## Examples

  #     iex> get_user!(123)
  #     %User{}

  #     iex> get_user!(456)
  #     ** (Ecto.NoResultsError)

  # # """
  # # def get_user!(id), do: Repo.get!(User, id)

  # @doc """
  # Creates a user.

  # ## Examples

  #     iex> create_user(%{field: value})
  #     {:ok, %User{}}

  #     iex> create_user(%{field: bad_value})
  #     {:error, %Ecto.Changeset{}}

  # """

  # def create_user(attrs \\ %{}) do
  #   %User{}
  #   |> User.changeset(attrs)
  #   |> Repo.insert()
  # end
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

    get_passenger(passenger.user_id)
  end

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

    get_driver(driver.user_id)
  end

  def get_driver(driver_user_id) do
    Repo.one!(
      from d in Driver,
        where: d.user_id == ^driver_user_id,
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

  def get_passenger(passenger_user_id) do
    Repo.one(
      from p in Passenger,
        where: p.user_id == ^passenger_user_id,
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

  def create_ride(
        ride_attrs = %{
          "passenger_id" => passenger_id,
          "driver_id" => driver_id,
          "pickup_lat" => pickup_lat,
          "pickup_lng" => pickup_lng,
          "destination_lat" => destination_lat,
          "destination_lng" => destination_lng
        }
      ) do
    IO.puts("These are the create_ride params")
    IO.inspect(ride_attrs)

    with driver <- get_driver(driver_id),
         {:ok, false} <- is_driver_suspended?(driver),
         {:ok, false} <- is_driver_on_ride(driver_id),
         {:ok, false} <- is_passenger_on_ride(passenger_id) do
      ride_changeset = Ride.changeset(%Ride{}, Map.put(ride_attrs, "current_status", "ongoing"))

      {:ok, created_ride} =
        Repo.transaction(fn ->
          case Repo.insert(ride_changeset) do
            {:ok, ride} ->
              ongoing_ride_changeset =
                OngoingRides.changeset(
                  %OngoingRides{},
                  %{ride_id: ride.id, passenger_id: ride.passenger_id, driver_id: ride.driver_id}
                )

              _ongoing_ride = Repo.insert(ongoing_ride_changeset)

              %{
                id: ride.id,
                passenger_id: ride.passenger_id,
                driver_id: ride.driver_id,
                current_status: ride.current_status
              }

            {:error, ride_error} ->
              ride_error
          end
        end)

      {:ok, created_ride}
    else
      {:error, error} -> {:error, error}
    end
  end

  def is_passenger_on_ride(passenger_id) do
    case Repo.get_by(OngoingRides, passenger_id: passenger_id) do
      nil -> {:ok, false}
      ride = %OngoingRides{} -> {:error, "Passenger On Ride id: #{ride.ride_id}"}
    end
  end

  def is_driver_on_ride(driver_id) do
    case Repo.get_by(OngoingRides, driver_id: driver_id) do
      nil -> {:ok, false}
      ride = %OngoingRides{} -> {:error, "Driver On Ride id: #{ride.ride_id}"}
    end
  end

  def is_driver_suspended?(driver) do
    if driver.suspended == true do
      {:error, "Driver Suspended"}
    else
      {:ok, false}
    end
  end

  def stop_ride(%{"ride_id" => ride_id}) do
    case Repo.get_by(OngoingRides, ride_id: ride_id) do
      ongoing_ride = %OngoingRides{} ->
        Repo.transaction(fn ->
          ride = get_ride(ride_id)
          done_ride = Ecto.Changeset.change(ride, %{current_status: "done"})

          with {:ok, updated_ride} <- Repo.update(done_ride),
               {:deleted, _ongoing_ride} <- delete_ongoing_ride(ongoing_ride) do
            IO.inspect(updated_ride)
            {:ok, updated_ride}
          else
            {:error, error} -> {:error, error}
          end
        end)

      nil ->
        {:error, "No Ongoing Ride "}
    end
  end

  def get_ride(ride_id) do
    Repo.get!(Ride, ride_id)
  end

  def delete_ongoing_ride(ongoing_ride) do
    case Repo.delete(ongoing_ride) do
      {:ok, %OngoingRides{}} -> {:deleted, ongoing_ride}
      {:error, error} -> {:error, error}
    end
  end

  def get_ongoing_rides() do
    query =
      from(on in OngoingRides,
        order_by: [desc: on.inserted_at, desc: on.id]
      )

    %{entries: entries, metadata: _metadataj} =
      Repo.paginate(query, cursor_fields: [:inserted_at, :id], limit: 50)

    entries
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
