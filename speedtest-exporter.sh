#!/bin/sh

IFS=';' read -r datetime server address ping jitter download upload share ip < <(/usr/local/bin/librespeed-cli --csv --csv-delimiter ";")

echo "# HELP speedtest_download Download Speed (Mbps)"
echo "# TYPE speedtest_download guage"
echo "speedtest_download  {server=\"${server}\"}  ${download}"

echo "# HELP speedtest_upload Upload Speed (Mbps)"
echo "# TYPE speedtest_upload guage"
echo "speedtest_upload  {server=\"${server}\"}  ${upload}"

echo "# HELP speedtest_jitter Jitter (ms)"
echo "# TYPE speedtest_jitter guage"
echo "speedtest_jitter  {server=\"${server}\"}  ${jitter}"

echo "# HELP speedtest_ping Ping (ms)"
echo "# TYPE speedtest_ping guage"
echo "speedtest_ping  {server=\"${server}\"}  ${ping}"

