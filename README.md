### About the Project
The project is designed to manage images uploaded by a (Hikvision) IP-Camera in a folder using FTP. The images in the `temp/` Folder are moved by the `move.sh` script in the right folder named by it's current date. Every night should be the `raffer.sh` script automatically started to render the images to one full video. Optionally the videos are uploaded to specific nextcloud server, configurable in `config.cfg`

### Prerequisites

* ffmpeg
  ```sh
  sudo apt install ffmpeg
* python3

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/maexled/camera-images-bash-manager.git
   cd camera-images-bash-manager/
   ```
2. Create files folder
   ```sh
   mkdir files
   ```
3. Define variables in `config.cfg`
   ```bash
    samba_user="samba"
    object_detection="true"
    check_for_broken_images="true"
    save_object_detection="true"
    save_to_nextcloud="true"
    nextcloud_host="https://yournextcloud.com"
    nextcloud_path="Videos"
    nextcloud_username="Maexled"
    nextcloud_password="YourSecretPassword"
4. Start `move.sh` in screen
    ```sh
   bash move.sh
   ```
5. Create crontab for `raffer.sh`, for example crontab -e
    ```sh
   15 0 * * * bash /camera/raffer.sh
   ```
   This will execute everyday 00:15 the raffer script makes the video then.

