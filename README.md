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
3. Define variables in `move.sh` like your temp folder where the images will be uploaded
   ```bash
    origin=/camera
    temp=$origin/temp
    samba_user=samba
4. Start `move.sh` and `raffer.sh` in screen
    ```sh
   bash move.sh
   bash raffer.sh
   ```
