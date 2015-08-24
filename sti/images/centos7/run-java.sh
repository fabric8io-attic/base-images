#!/bin/sh

app_dir=${JAVA_APP_DIR:-/app}

# Read in configurt if given
if [ -f "${app_dir}/setenv.sh" ]; then
   . ${app_dir}/setenv.sh
fi

java_options="$JAVA_OPTIONS $(agent-bond-opts)"
if [ "x$JAVA_ENABLE_DEBUG" != "x" ]; then
    debug_port=${JAVA_DEBUG_PORT}:-5005}
    java_options="${java_options} -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=${debug_port}"
fi
work_dir=${JAVA_WORKDIR:-${app_dir}}
classpath=${JAVA_CLASSPATH:-"classes:${java_app_dir}/*"}

# Try hard to find a sane default if no main class and no main class
# is specified explicitely
if [ -z $JAVA_MAIN_CLASS ] && [ -z $JAVA_APP_JAR ]; then
   # Filter out temporary jars from the shade plugin
   nr_jars=`ls $app_dir/*.jar | grep -v '/original-' | wc -l | tr -d '[[:space:]]'`
   if [ $nr_jars = 1 ]; then
     jar_file=`ls $app_dir/*.jar | grep -v '/original-'`
     cp_ext="${app_dir}"
   else
     echo "Neither \$JAVA_MAIN_CLASS nor \$JAVA_APP_JAR is set and ${nr_jars} jar files are in ${app_dir} (only 1 is expected when using auto-mode)"
     exit 1
   fi
fi

cd ${work_dir}

if [ "x$JAVA_APP_JAR" != "x" ];  then
   if [ -f "$JAVA_APP_JAR" ]; then
       jar_file="$JAVA_APP_JAR"
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
