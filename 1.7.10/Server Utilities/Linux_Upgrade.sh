clear
echo -e '\E[37;44m'"\033[1m===================================================\033[0m"
echo -e '\E[37;44m'"\033[1m= OMEGA ADVENTURE PACK SERVER UPGRADE SCRIPT      =\033[0m"
echo -e '\E[37;44m'"\033[1m===================================================\033[0m"
echo -e "Type the version you are upgrading to (e.g. 3.34):"
read UPGRADE_VERSION
echo ""

#Set Global OMEGA ADVENTURE PACK Upgrade Script Variables
declare SERVER_FOLDERNAME="Omega-Adventure-Pack"
declare UPGRADE_STORAGE="SERVER_BACKUP"
declare MINECRAFT_VERSION="1.7.10"

echo -e '\E[37;44m'"\033[1m BACKING UP SERVER DATA... \033[0m"
mkdir -p "$UPGRADE_STORAGE/config/aroma1997"
mkdir -p "$UPGRADE_STORAGE/mods"
mkdir -p "$UPGRADE_STORAGE/local/ftbu"

declare -a BACKUP_FILES=(
"local/ftbu/config.json"
"config/aroma1997/AromaBackup.cfg"
"config/tickDynamic.cfg"
"ops.json"
"server.properties"
"usercache.json"
"usernamecache.json"
"banned-ips.json"
"banned-players.json"
"crash-reports"
"eula.txt"
"whitelist.json"
"mods/TickDynamic-1.7.10-0.1.5.jar"
"world"
"Launch_Server.sh"
"STOP_NOTICE.sh"
"UPDATE_NOTICE.sh"
)

for file in "${BACKUP_FILES[@]}"
	do
		mv -v "$SERVER_FOLDERNAME/$file" "$UPGRADE_STORAGE/$file"
	done
rm -r $SERVER_FOLDERNAME
echo ""

echo -e '\E[37;44m'"\033[1m DOWNLOADING OMEGA ADVENTURE PACK v$UPGRADE_VERSION FROM GITHUB... \033[0m"
echo "Downloading OMEGA ADVENTURE PACK from local Samba server..."
wget "https://github.com/cyberstrawberry101/Omega-Adventure-Pack/archive/v$UPGRADE_VERSION.tar.gz"
echo ""

echo -e '\E[37;44m'"\033[1m EXTRACTING OMEGA ADVENTURE PACK v$UPGRADE_VERSION... \033[0m"
tar -xvf "v$UPGRADE_VERSION.tar.gz"
mv "$SERVER_FOLDERNAME-$UPGRADE_VERSION" "$SERVER_FOLDERNAME"
rm -r "v$UPGRADE_VERSION.tar.gz"
cd "$SERVER_FOLDERNAME/$MINECRAFT_VERSION"
cp -rvP config ..
cp -rvP scripts ..
cp -rvP  mods ..
echo ""

echo -e '\E[37;44m'"\033[1m COPYING MINECRAFT AND FORGE SERVER DATA... \033[0m"
cd "Server Utilities/Server Files"
cp -rvP scripts ../../..
cp -rvP libraries ../../..
cp -rvP minecraft_server.1.7.10.jar ../../..
cp -rvP forge-1.7.10-10.13.4.1614-1.7.10-universal.jar ../../..
cd ../../..
rm -r $MINECRAFT_VERSION
rm -r README.md
mkdir -p "config/aroma1997"
mkdir -p "local/ftbu"
cd ..
echo ""

echo -e '\E[37;44m'"\033[1m MOVING BACKED UP FILES TO NEW SERVER... \033[0m"
for file in "${BACKUP_FILES[@]}"
	do
		mv -v "$UPGRADE_STORAGE/$file" "$SERVER_FOLDERNAME/$file"
	done
rm -r $UPGRADE_STORAGE
echo ""

echo -e '\E[37;44m'"\033[1m DELETING CLIENT-SIDED MODS FROM SERVER... \033[0m"
find "$SERVER_FOLDERNAME/mods" -name '*client*.jar' -exec rm {} +
echo ""

echo -e '\E[37;44m'"\033[1m OMEGA ADVENTURE PACK SERVER UPGRADE TO V$UPGRADE_VERSION COMPLETE! \033[0m"
