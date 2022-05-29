defmodule Test do
  alias Nerves.Runtime.KV

  def is_auth_key(_key, _user, _options) do
    # Let the whole world in for now
    true
  end

  defdelegate host_key(alg, opts), to: NervesSSH.Keys

  def pwdfun(_, _, _, s), do: {true, s}

  def next_active() do
    if KV.get("nerves_fw_active") == "a", do: "b", else: "a"
  end

  @spec run(String.t()) :: :ok | :fail | :busy | :updating
  def run(expected_uuid) do
    with :ready <- status() do
      Agent.update(TestStatus, fn _ -> :busy end)

      result =
        if Nerves.Runtime.KV.get_active("nerves_fw_uuid") == expected_uuid do
          :ok
        else
          :fail
        end

      Agent.update(TestStatus, fn _ -> :ready end)
      result
    end
  end

  def status(), do: maybe_updating() || Agent.get(TestStatus, & &1)

  defp maybe_updating() do
    # Check if the fwup port is running to indicating this is actively
    # installing an update from another job
    Enum.find_value(Port.list(), &(Port.info(&1)[:name] == '/usr/bin/fwup' and :updating))
  end
end
