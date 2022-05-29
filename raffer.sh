echo Starting;

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/config.cfg

log=$DIR/raffer.txt;

datediryesterday=$DIR/files/$(date --date='-1 day' +'%Y/%m/%d')

fulldateyesterday=$(date --date='-1 day' +'%Y-%m-%d')

echo "Starting for $fulldateyesterday" >> $log;

echo "Checking for broken images..."
python3 $DIR/delete_broken_images.py -f $datediryesterday

cd $datediryesterday
zip $fulldateyesterday.zip *.jpg

if [ "$save_object_detection" == "true" ]; then
	zip -r $fulldateyesterday-object-detection.zip object-detection/
fi

ls *.jpg | cat -n | while read n f; do mv "$f" "$n.jpg"; done #alle bilder numerieren
for f in *.jpg ; do if [[ $f =~ [0-9]+\. ]] ; then  mv $f `printf "%.5d" "${f%.*}"`.jpg  ; fi ; done # alle numerierungen mit nullen auffüllen
ffmpeg -framerate 10 -i %05d.jpg -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $datediryesterday/$fulldateyesterday.mp4 # video bauen

rm *.jpg
rm -rf object-detection

# Upload Video to Nextcloud
if [ "$save_to_nextcloud" == "true" ]; then
	curl -T $datediryesterday/$fulldateyesterday.mp4 -u $nextcloud_username:$nextcloud_password "$nextcloud_host/remote.php/dav/files/$nextcloud_username/$nextcloud_path/$fulldateyesterday.mp4"
fi

echo "Finished" >> $log;
