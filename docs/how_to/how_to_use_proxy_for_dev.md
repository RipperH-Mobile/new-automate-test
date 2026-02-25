# How to use Proxy for Development

## IOS

1. Find development device IP.
2. Config Wi-Fi proxy in device settings.
    - Go to Settings > Wi-Fi.
    - Select the network you are connected to. (Tap the "i" icon next to the network name.)
    - Scroll down to the bottom and select "Configure Proxy".
    - Select "Manual".
    - Enter the IP address of your proxy server in the "Server" field.
    - Enter the port number of your proxy server in the "Port" field. (Default for the ProxyMan is 9090)
    - And select "Save" in the top right corner.

3. Configure additional environment variables following:
```
PROXY_ENABLED="TRUE"
PROXY_HOST="DEVELOPEMENT DEVICE IP"
PROXY_PORT="9090"
```