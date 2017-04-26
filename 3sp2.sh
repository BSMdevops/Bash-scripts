#!/bin/bash
# Script should be run from the OPT directory and TAR.GZ file from QA 
# should be placed in the OPT directory first before running script
# Delcare any variables and create directories up front
TEMP_DIR=/tmp
BACKUP_DIR=/opt/backup
PATCH_DIR=/opt/etl
SPARK_DIR=/opt/spark
command |& tee ~/patchlog.txt
mkdir -p /opt/etl
mkdir -p /opt/backup
# Patch update Production Environment
# Check for exsiting files, directories, locations and perform backup and confirm before procedding.
# Stopping Spark streaming determine which is the Master first , then stop it.
# Script being devloped to identify MASTER Spark instance
#Stopping Spark Services
	echo "Stopping Spark Services"
		service spark stop
	
# Make backup Spark directory
		echo "Making backup of previous version of Spark to /opt/backup"
		cp -rL   /opt/spark/* /opt/backup
# Copy any addtional old configuration files to the backup directory
#echo "Copying settings to backup directory"
#cp $INSTALL_DIR/config/special file $BACKUP_DIR/config/
#cp $INSTALL_DIR/config/special file $BACKUP_DIR/config/
#cp -R $INSTALL_DIR/config/special file $BACKUP_DIR/config/
#cp -R $INSTALL_DIR/config/special file $BACKUP_DIR/config/
#Backup any special configuration files and compare to new files which
#are shown on the screen
		#if ! diff $INSTALL_DIR/config.xml $TEMP_DIR/config.xml -w > /dev/null
		#then
			#echo "config.xml replaced by the new one - make sure to restore your changes"
			#echo "diff $INSTALL_DIR/config.xml $TEMP_DIR/config.xml:"
			#diff $INSTALL_DIR/config.xml $TEMP_DIR/config.xml -w
			#echo
		#fi
		#echo "!!! Defaults.xml and config.xml updated with new versions !!!"
	#else
		#mv $$TEMP_DIR/Spark streaming $INSTALL_DIR/
		#echo "New version Spark streaming installed"
	#fi

#Check for directory and file locations, download new patch files and extract.
#Check for root priviledges
	if [[ $(id -u) != 0 ]]
				then
			echo "Superuser (root) priviledges are required"
			echo "Please login as Root"
		exit 1
	fi
#get the file from location \\webtech.local\Corp_share_bu\SWENG\Build\
	gzip -c etl_stream.tar.gz | tar -xzvf etl_stream.tar.gz -C /opt/etl
#Starting the Spark Streaming for the first time
	cd /opt/etl/bin
	sh startETLStreaming.sh 
