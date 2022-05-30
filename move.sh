echo Starting;

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/config.cfg

echo "Current path is $DIR"

temp=$DIR/temp

# Count number of checks
check=1;

# For longtime picture of the hour to move at least every hour a picture if enabled
last=-1;

while [ true ]; do
	date=$(date --date='+0 hour' +'%m/%d/%Y, %H:%M:%S')
	datedir=$(date --date='+0 hour' +'%Y/%m/%d')
	
	if [[ ! -d $DIR/files/$datedir/ ]]
	then
		echo "Set ownership of $origin/files/$datedir to samba"
		mkdir -p $DIR/files/$datedir
		if [ "$object_detection" == "true" ]; then
			mkdir -p $DIR/files/$datedir/object-detection
		fi
		chown -R $samba_user $DIR/files/$datedir
	fi

	# Count number of pictures
	num=0;
	for f in $temp/*.jpg; do
		if [ -f "$f" ] # does file exist?
		then
			chown $samba_user $f
			# Save pictures at least every new hour in longtime
			if [ "$save_longtime_pictures" == "true" ]; then
				if [ $(date +%H) -ne $last ]
				then
					echo "New longtime picture, now $(date +%H), last was $last"
					cp $f $DIR/files/raffer/longtime/
					last=$(date +%H);
				fi
			fi
			num=$((num + 1));
			echo $f
			
			if [ "$object_detection" == "true" ]; then
				python3 $DIR/object-detection/deep_learning_object_detection.py --prototxt $DIR/object-detection/MobileNetSSD_deploy.prototxt.txt --model $DIR/object-detection/MobileNetSSD_deploy.caffemodel --image $f --save $DIR/files/$datedir/object-detection/${f##*/} 
			fi
			cp $f $DIR/latest.jpg
			mv $f $DIR/files/$datedir;
		fi
	done;
	check=$((check + 1));
	sleep 1;
done;
