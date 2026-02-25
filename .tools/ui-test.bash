#!/bin/bash
# declare -a test_file=('file1.dart' 'file2.dart' 'file3.dart')
declare -a test_file=('delete_account_test.dart')

rm report.txt
for i in "${test_file[@]}"
do
    echo "Tested FAILED: $i">> report.txt
done

for i in "${test_file[@]}"
do
    echo "Start Testing: $i"
    SECONDS=0
    /Users/zimpligitalnj/mobile_app_flutter/flutter/bin/flutter drive --driver=test_driver/integration_test.dart --target=integration_test/"$i" || continue;
    date_now=$(date +%Y-%m-%d-%H:%M)
    duration=$SECONDS
    echo "Test for $duration seconds"
    sed "s/Tested FAILED: $i/Tested SUCCEED: $i - $date_now : $duration seconds/g" report.txt > temp ; mv temp report.txt
done