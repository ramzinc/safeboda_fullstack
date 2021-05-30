defmodule SafebodaFullstack.Admin do
  @derive Jason.Encoder
  defstruct email: nil, password: nil
  alias SafebodaFullstack.Admin

  def authenticate_admin_user(_admin, email, password) do
    if %Admin{email: "mpiima@protonmail.com", password: "B3stp4ssw0rd"} == %Admin{
         email: email,
         password: password
       } do
      %Admin{email: "mpiima@protonmail.com", password: "B3stp4ssw0rd"}
    else
      "The Email OR Password Entered are false"
    end
  end

  def get_admin_user() do
    %Admin{email: "mpiima@protonmail.com", password: "B3stp4ssw0rd"}
  end
end
