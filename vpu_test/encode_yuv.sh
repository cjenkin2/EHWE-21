if [[ ($# -ne 5) && ($# -ne 6) ]]
then
	echo "usage: $0 <input_yuv> <output_vid> <width> <height> <cap> [vpu_params]"
	exit 65 # bad parameters
fi


INPUT_YUV=$1
OUTPUT_FILE=$2
WIDTH=$3
HEIGHT=$4
CAP=$5

# vpuencoder params
if [[ -z $6 ]]
then
	PARAMS=""
else
	PARAMS=$6
fi

#helper functions
function set_date()
{
        DATE="$(date)"
        DATE="${DATE// /_}"
        DATE="${DATE//:/-}"
}

#export variables
export GST_DEBUG_DUMP_DOT_DIR="$(pwd)/temp"

# local variables
let "BLOCKSIZE = ($WIDTH * $HEIGHT * 3) / 2"
YUV_BASENAME=$(basename $INPUT_YUV)
LOGFILE="encode.log"
GRAPHDIR="$(pwd)/graphs"
DOTDIR="$(pwd)/dots"
MD5="$OUTPUT_FILE.md5sum"

#code
set_date
echo "============================" >> $LOGFILE
echo "$DATE"                        >> $LOGFILE
echo "encoding: $INPUT_YUV"         >> $LOGFILE
echo "format  : $CAP"               >> $LOGFILE
echo "params  : $PARAMS"            >> $LOGFILE
echo "----------------------------" >> $LOGFILE

echo "using pipeline: gst-launch filesrc location=$INPUT_YUV blocksize=$BLOCKSIZE !" \
"\"video/x-raw-yuv,format=(fourcc)I420,width=$WIDTH,height=$HEIGHT\" ! " \
"mfw_vpuencoder $PARAMS ! $CAP ! " \
"tee name=t ! queue ! filesink location=$OUTPUT_FILE" \
"t. ! queue ! avimux ! filesink location=$OUTPUT_FILE.avi" >> $LOGFILE

GST_LAUNCH_OUTPUT=$(timeout 240 gst-launch filesrc location=$INPUT_YUV blocksize=$BLOCKSIZE ! \
"video/x-raw-yuv,format=(fourcc)I420,width=$WIDTH,height=$HEIGHT" ! \
mfw_vpuencoder $PARAMS ! $CAP ! \
tee name=t ! queue ! filesink location=$OUTPUT_FILE \
t. ! queue ! avimux ! filesink location=$OUTPUT_FILE.avi)
md5sum $OUTPUT_FILE > $MD5
echo "$GST_LAUNCH_OUTPUT" >> $LOGFILE

#rename generated dot files
./dot_cleanup.sh "$YUV_BASENAME.$DATE" "gst-launch"

#make graph of PAUSED_READY
echo $(./mk_pipeline_graph.sh "READY_PAUSED" $DATE) | tee -a $LOGFILE | cat
