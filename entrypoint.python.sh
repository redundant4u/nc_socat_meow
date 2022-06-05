#!/bin/bash

useradd -U -u 1000 -l $USER

chown $USER:$USER /home/$PROBLEM/$PROBLEM.py 2> /dev/null || true
chown $USER:$USER /home/$PROBLEM/flag 2> /dev/null || true

chmod 400 /home/$PROBLEM/$PROBLEM.py  2> /dev/null || true
chmod 400 /home/$PROBLEM/flag 2> /dev/null || true

cd /home/$PROBLEM

SCRIPT=("socat TCP-LISTEN:$PORT,reuseaddr,fork EXEC:'su $USER -c /home/$PROBLEM/py.sh'")

echo $(eval $SCRIPT)
