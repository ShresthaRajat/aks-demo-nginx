#!/bin/sh

host_name=$(cat hostname)

echo "Content-type:text/html"
echo ""
echo "<html><head>"
echo "<title>${host_name}</title>"
echo '<meta http-equiv="Content-type" content="text/html;charset=UTF-8">'
echo "</head><body>"
echo "HOSTNAME : ${host_name}"
echo "</body></html>"
