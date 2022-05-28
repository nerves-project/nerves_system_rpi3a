defmodule Test.Application do
  @moduledoc false

  use Application

  @wg_conf "/etc/wireguard/wg0.conf"

  @impl true
  def start(_type, _args) do
    configure_wireguard()
    start_distribution()

    Supervisor.start_link([], [strategy: :one_for_one, name: Test.Supervisor])
  end

  defp configure_wireguard() do
    if File.exists?(@wg_conf) do
      config = VintageNetWireguard.ConfigFile.parse(@wg_conf)
      VintageNet.configure("wg0", config)
    end
  end

  defp start_distribution() do
    :os.cmd('epmd -daemon')
    {:ok, host} = :inet.gethostname()
    node = Application.get_env(:test, :node_name, "nerves@#{host}.local")
    Node.start(:"#{node}")
    Node.set_cookie(:test_cookie)
  end

  def target() do
    Application.get_env(:test, :target)
  end
end
