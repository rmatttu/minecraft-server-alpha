#!/bin/sh

#minecraftディレクトリの重要なファイルのみ固め、
#dropboxへアップロードします

# Usage
# ./backup.sh


# Main script
start_time=`date +%s`

# crop等で実行するとrootで実行することになるため
cd `dirname $0`

#d=`date "+[%Y_%m_%d]_%H_%M_%S"`
# 月ごとのファイルにする
d=`date "+%Y_%m"`
generate_archive_name=alpha_${d}.zip
echo generate_archive_name=${generate_archive_name}

# minecraft dataディレクトリを圧縮（*.jarを除く）
# zip -9r ./backup/${generate_archive_name} ./data -x *.jar
tar -Jcf ./backup/${generate_archive_name} ./data

# upload
./Dropbox-Uploader/dropbox_uploader.sh upload ./backup/${generate_archive_name} ${generate_archive_name}

end_time=`date +%s`
time=$((end_time - start_time))
echo $time

