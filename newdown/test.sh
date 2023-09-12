cd
echo `ps aux | egrep "^[^ ]+ $$" | awk '{print $1}'`
