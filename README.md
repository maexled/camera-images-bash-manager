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
3. Define variables in `move.sh` and `raffer.sh` like your temp folder where the images will be uploaded
   ```bash
    origin=/camera
    temp=$origin/temp
    samba_user=samba
4. Start `move.sh` in screen
    ```sh
   bash move.sh
   ```
5. Create crontab for `raffer.sh`, for example crontab -e
    ```sh
   15 0 * * * bash /camera/raffer.sh
   ```
   This will execute everyday 00:15 the raffer script makes the video then.

