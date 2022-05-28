defmodule Test do
  def is_auth_key(_key, _user, _options) do
    # Let the whole world in for now
    true
  end

  defdelegate host_key(alg, opts), to: NervesSSH.Keys

  def pwdfun(_, _, _, s), do: {true, s}
end
