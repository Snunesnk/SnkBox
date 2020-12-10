# SnkBox
My own automated media server deployment script + script to launch all / specified services + script to stop all / specified services, with docker contenerisation for all services, and vpn config throught openVpn
reverse-proxy trought apashe (if user has domain name)
port-forwarding (if user is not in NAT network)
option to choose between couchpotato / radarr - plex / jellyfin
option to add usenet (if user has usenet indexer + usenet provider)

Software installed :

- Portainer
- Transmission
- NewsHosting
- NZBGet
- Jackett
- Sonarr
- Radarr / couchpotato
- Lidarr
- Bazarr (Maybe)
- LazyLibrarian
- Ombi
- Plex / Jellyfin
- Apashe


Could be great to just have one script to launch like ./snkbox init | ./snkbox deploy [service] | ./snkbox stop [service]

Maybe a small webpage to be able to easely access all services for admin / Easely switch between Plex / Jellyfin and Ombi for users
