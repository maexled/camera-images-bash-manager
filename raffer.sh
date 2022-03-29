echo Starting;

origin=/camera

log=$origin/raffer.txt;

datediryesterday=$origin/files/$(date --date='-1 day' +'%Y/%m/%d')

fulldateyesterday=$(date --date='-1 day' +'%Y-%m-%d')

printf "Starting for $fulldateyesterday" >> $log;

cd $datediryesterday
zip $fulldateyesterday.zip *.jpg
zip -r $fulldateyesterday-object-detection.zip object-detection/

ls *.jpg | cat -n | while read n f; do mv "$f" "$n.jpg"; done #alle bilder numerieren
for f in *.jpg ; do if [[ $f =~ [0-9]+\. ]] ; then  mv $f `printf "%.5d" "${f%.*}"`.jpg  ; fi ; done # alle numerierungen mit nullen auffüllen
ffmpeg -framerate 10 -i %05d.jpg -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p $datediryesterday/$fulldateyesterday.mp4 # video bauen

rm *.jpg
rm -rf object-detection

# Upload Video to Nextcloud
curl -T $datediryesterday/$fulldateyesterday.mp4 -u 'Maexled:ZVH3WafCCEU3bhZx' "https://nextcloud.maexled.de/remote.php/dav/files/Maexled/Kamera-Videos/$fulldateyesterday.mp4"

printf "Finished" >> $log;
