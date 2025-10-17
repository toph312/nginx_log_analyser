#!/bin/bash
file=nginx-access.log


echo "========== NGINX LOG REPORT =========="

# Top 5 most requested paths
#########################################
# Uniq can only count consecutive identical rows,so need to sort first
# uniq -c ,-c will count the number of times each unique value appears.
echo
echo 'Top 5 IP addresses with the most requests:'
awk '{print $1}' "$file" | sort | uniq -c | sort -k1,1 -rn | head -5

# Top 5 most requested paths
#########################################
echo
echo 'Top 5 most requested paths:'
awk '{ match($0, /"[^ ]+ ([^ ]+) HTTP/, arr); if (arr[1] != "") print arr[1]; }' nginx-access.log | sort | uniq -c | sort -k1,1 -rn | head -5

 # Top 5 response status codes
#########################################
echo
echo 'Top 5 response status codes:'
awk '{
  if (match($0, /HTTP\/[0-9.]+" ([0-9]{3}) /, arr)) {
    print arr[1]
  }
}' nginx-access.log | sort | uniq -c | sort -k1,1nr | head -5

# Top 5 user agents
#########################################
echo
echo 'Top 5 user agents:'
awk '{
  if (match($0, /\((https?:\/\/)?([^/)]+)\)/, a)) {
    print a[2]
  }
}' nginx-access.log | sort | uniq -c | sort -k1,1nr | head -5
