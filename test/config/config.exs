import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :test, target: Mix.target()

config :nerves,
  erlinit: [hostname_pattern: "nerves-%s"],
  firmware: [rootfs_overlay: "rootfs_overlay"],
  source_date_epoch: "1653759283"

config :logger, backends: [RingLogger]

config :shoehorn, init: [:nerves_runtime, :nerves_pack, :nerves_ssh]

config :nerves_runtime,
  kernel: [use_system_registry: false],
  kv: [nerves_fw_vcs_identifier: System.get_env("NERVES_FW_VCS_IDENTIFIER")]

if encoded = System.get_env("WIREGUARD_DEVICE_CONF") do
  File.mkdir_p!("rootfs_overlay/etc/wireguard")
  File.write!("rootfs_overlay/etc/wireguard/wg0.conf", Base.decode64!(encoded))
end

config :nerves_ssh,
  daemon_option_overrides: [key_cb: Test, pwdfun: &Test.pwdfun/4]

config :vintage_net,
  regulatory_domain: "US",
  additional_name_servers: [{127, 0, 0, 53}],
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"wlan0",
     %{
       ipv4: %{method: :dhcp},
       type: VintageNetWiFi,
       vintage_net_wifi: %{
         networks: [%{key_mgmt: :wpa_psk, psk: "n3wh0us3", ssid: "kabellos"}]
       }
     }}
  ]

config :mdns_lite,
  # The `hosts` key specifies what hostnames mdns_lite advertises.  `:hostname`
  # advertises the device's hostname.local. For the official Nerves systems, this
  # is "nerves-<4 digit serial#>.local".  The `"nerves"` host causes mdns_lite
  # to advertise "nerves.local" for convenience. If more than one Nerves device
  # is on the network, it is recommended to delete "nerves" from the list
  # because otherwise any of the devices may respond to nerves.local leading to
  # unpredictable behavior.

  hosts: [:hostname, "nerves-rpi3a"],
  dns_bridge_enabled: true,
  dns_bridge_ip: {127, 0, 0, 53},
  dns_bridge_port: 53,
  dns_bridge_recursive: true,
  ttl: 120,

  # Advertise the following services over mDNS.
  services: [
    %{
      protocol: "ssh",
      transport: "tcp",
      port: 22
    },
    %{
      protocol: "sftp-ssh",
      transport: "tcp",
      port: 22
    },
    %{
      protocol: "epmd",
      transport: "tcp",
      port: 4369
    }
  ]
