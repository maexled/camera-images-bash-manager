echo Starting;

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/config.cfg

echo "Current path is $DIR"

temp=$DIR/temp

millis=$(date --date='+0 hour' +%s);
log=$DIR/move.txt;
echo "Log File - " > $log;
date >> $log;

check=1;

last=-1;

while [ true ]; do
	date=$(date --date='+0 hour' +'%m/%d/%Y, %H:%M:%S')
	datedir=$(date --date='+0 hour' +'%Y/%m/%d')
	if [[ ! -d $DIR/files/$datedir/ ]]
	then
		echo "Set ownership of $origin/files/$datedir to samba"
		mkdir -p $DIR/files/$datedir
		mkdir -p $DIR/files/$datedir/object-detection
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
				cp $f $DIR/files/raffer/longtime/
				last=$(date +%H);
				echo "move picture of the hour" >> $log;
			fi
			num=$((num + 1));
			echo $f >> $log;
			echo $f;
			
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
