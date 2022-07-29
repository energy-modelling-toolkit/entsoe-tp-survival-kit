# Don't forget to replace YOUR_TP_USERNAME and 
# YOUR_TP_PASSWORD with your user/pass for the
# ENTSO-E TP
export SSHPASS=YOUR_TP_PASSWORD
/usr/bin/sshpass -e sftp -o ProxyCommand='/usr/bin/nc --proxy-type http --proxy-auth felicma:Please --proxy ps-pet-usr.cec.eu.int:8012 %h %p' -oBatchMode=no -b - "YOUR_TP_USERNAME"@sftp-transparency.entsoe.eu << !
   cd TP_export/AggregatedGenerationPerType_16.1.B_C
   mget 2020*.csv
   mget 2021*.csv
   mget 2022*.csv
   bye
!
