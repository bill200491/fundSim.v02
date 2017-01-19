#!/bin/sh

cd $1
rm -rf cloud.last emuRlt cloud.new cloud.old cloud.slv 
rm -rf slvRlt slvRlt.old slvRlt.new $2.log $3.log
cp -r cloud cloud.last


bzip2 -dc ../../simRlt/mutual/$2 | tar xvf - > $2.log
rm -rf slvRlt/*.log
mkdir cloud.new
cp slvRlt/*.dat cloud.new/
mv slvRlt slvRlt.new

rm -rf cloud
# cp -r ../cloud .
morn-mutual-update.py simList.json jpmorgan || exit 1
bzip2 -dc ../../simRlt/mutual/$3 | tar xvf - > $3.log
rm -rf slvRlt/*.log
mkdir cloud.old
cp slvRlt/*.dat cloud.old/
mv slvRlt slvRlt.old


mkdir slvRlt emuRlt
screen_mdl06.py  simList.json jpmorgan fast || exit 1
mkdir cloud.slv
cp slvRlt/*.dat cloud.slv

rm -rf report.del
mv report.bak report.del
cp -r report report.bak
cp emuRlt/*.png report/
reportE_mdl06.py ../fundList.json jpmorgan

# cd ../
# git config --global user.email "aphou6866@gmail.com"
# git config --global user.name "Elliot Hou, Ao-ping"
# git commit -m "Commit for `date`" .
# git push

echo "All report FINISHED"
echo "All report FINISHED"
echo "All report FINISHED"
