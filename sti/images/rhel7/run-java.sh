#!/bin/sh

java_options="$JAVA_OPTIONS $(agent-bond-opts)"
app_dir=${JAVA_APP_DIR:-/app}
work_dir=${JAVA_WORKDIR:-${app_dir}}
classpath=${CLASSPATH:-"classes:${java_app_dir}/*"}

if [ -z $JAVA_MAIN_CLASS ] && [ -z $JAVA_APP_JAR ]; then
   nr_jars=`ls $app_dir/*.jar | wc -l | tr -d '[[:space:]]'`
   if [ $nr_jars = 1 ]; then
     jar_file=`ls $app_dir/*.jar`
   else
     echo "Neither \$JAVA_MAIN_CLASS nor \$JAVA_APP_JAR is set and ${nr_jars} jar files are in ${app_dir} (only 1 is expected when using auto-mode)"
     exit 1
   fi
fi

cd ${work_dir}

if [ "x$JAVA_APP_JAR" != "x" ];  then
   if [ -f $JAVA_APP_JAR ]; then
       jar_file=$JAVA_APP_JAR
       cp_ext="${app_dir}"
   elif [ -f "${app_dir}/$JAVA_APP_JAR" ]; then
       jar_file="${app_dir}/$JAVA_APP_JAR"
       cp_ext="${app_dir}:${work_dir}"
   else
       echo "No JAR File $JAVA_APP_JAR found"
       exit 1
   fi
fi

if [ "x$jar_file" != "x" ] ; then
   exec java $java_options -cp ${cp_ext} -jar $jar_file $*
else
   exec java $java_options -cp ${classpath}:${app_dir}:${work_dir} $JAVA_MAIN_CLASS $*
fi
