# SnkBox
My own automated media server deployment script + script to launch all / specified services + script to stop all / specified services, with docker contenerisation for all service. Uses only usenet.
reverse-proxy through nginx (if user has domain name) + ssl certification with certbot (TO DO)

Software installed :

- NZBGet     -- NZB downloader tool
- Sonarr     -- TV shows search tool
- Radarr     -- Movies search tool
- Ombi       -- User-friendly interface to search / request movies and TV shows
- Jellyfin   -- Free and open-source alternative to plex, used to play all downloaded media
- Nginx      -- Take care of the good communication between all sofrwares, behind a reverse proxy.
- NZBHydra2  -- Gather all indexers in one place, so we don't have to repeteadly add indexers in sonarr and radarr. Get nice logs / charts too.
- WatchTower -- Automatically update all container's image when needed.
- HandBrake  -- Transcode each downloaded file, so it could by direct-played even on remote storage


I need to improve my start-up script to really init a maximum of things
Missing (non-exhaustive):
	- mergerfs
	- 1fichierfs
	- rclone
	- certbot
	- nginx

I need to understand rust better to build a stable and strong web-server (even if there's not that much services)

# TODO

- Change deploy scripts to check if container is already in use or not
- Improve user's interface (and admin why not)
- find a way to upload directly indexers in nzbhydra2
- Check if I use watchTower correctly
