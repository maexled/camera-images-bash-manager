echo Starting;

origin=/camera
temp=$origin/temp
samba_user=samba

millis=$(date --date='+0 hour' +%s);
log=move.txt;
printf "Log File - " > $log;
date >> $log;

check=1;

last=-1;

while [ true ]; do
	date=$(date --date='+0 hour' +'%m/%d/%Y, %H:%M:%S')
	datedir=$(date --date='+0 hour' +'%Y/%m/%d')
	if [[ ! -d $origin/files/$datedir/ ]]
	then
		echo "Set ownership of $origin/files/$datedir to samba"
		mkdir -p $origin/files/$datedir
		mkdir -p $origin/files/$datedir/object-detection
		chown -R $samba_user $origin/files/$datedir
	fi
	# echo -e "$date Run Check #$check";
	num=0;
	for f in $temp/*.jpg; do
		if [ -f "$f" ] # does file exist?
		then
			chown -R samba $f
			if [ $(date +%H) -ne $last ]
			then
				echo "$(date +%H) and $last" >> $log;
				cp $f $origin/files/raffer/longtime/
				last=$(date +%H);
				echo "move picture of the hour" >> $log;
			fi
			num=$((num + 1));
			echo $f >> $log;
			echo $f;
			python3 $origin/object-detection/deep_learning_object_detection.py --prototxt $origin/object-detection/MobileNetSSD_deploy.prototxt.txt --model $origin/object-detection/MobileNetSSD_deploy.caffemodel --image $f --save $origin/files/$datedir/object-detection/${f##*/} 
			cp $f $origin/latest.jpg
			mv $f $origin/files/$datedir;
		fi
	done;
	check=$((check + 1));
	sleep 1;
done;
