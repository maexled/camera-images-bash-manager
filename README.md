## About the Project
The project is designed to manage images uploaded by a (Hikvision) IP-Camera in a folder using FTP. The images in the `temp/` Folder are moved by the `move.sh` script in the right folder named by it's current date. Every night should be the `raffer.sh` script automatically started to render the images to one full video. Optionally the videos are uploaded to specific nextcloud server, configurable in `config.cfg`

## Prerequisites

* ffmpeg
  ```sh
  sudo apt install ffmpeg
* python3

## Installation
### Be stupid and do it with bash

1. Clone the repo
   ```sh
   git clone https://github.com/maexled/camera-images-bash-manager.git
   cd camera-images-bash-manager/
   ```
3. Install needed python libraries
   ```sh
   pip install -r requirements.txt 
   ```
3. Create files folder
   ```sh
   mkdir files
   ```
4. Define variables in `config.cfg`
   ```bash
   fps="10"
   raffer_execution="00:15"
   samba_user="samba"
   object_detection="true"
   check_for_broken_images="true"
   save_longtime_pictures="true"
   save_object_detection="true"
   save_to_nextcloud="true"
   nextcloud_host="https://yournextcloud.com"
   nextcloud_path="Videos"
   nextcloud_username="Maexled"
   nextcloud_password="YourSecretPassword"
   ```
   - `samba_user` - is the user who will own the moved files
   - `raffer_execution` - if you want to execute raffer in other ways (e.g cron), keep it empty
   
   The other variables should be self-explanatory

5. Start `move.sh` in screen
    ```sh
   bash move.sh
   ```
6. Create crontab for `raffer.sh`, for example crontab -e
    ```sh
   15 0 * * * bash /camera/raffer.sh
   ```
   This will execute everyday 00:15 the raffer script makes the video then.

### Be smart and do it with docker!
```sh
docker run \
   --name camera-images-manager \
   -v /home/max/cameratest/files:/camera/files \
   -v /home/max/cameratest/temp:/camera/temp \
   -v /home/max/cameratest/config.cfg:/camera/config.cfg \
   -e TZ=Europe/Berlin \
   ghcr.io/maexled/camera-images-bash-manager
```
#### Configuration variables in config.cfg:
- `samba_user` - recommened to set it as root. In container no extra user will be created.

