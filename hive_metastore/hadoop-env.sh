#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Set Hadoop-specific environment variables here.

# The java implementation to use. By default, this environment
# variable is REQUIRED on ALL platforms except OS X!
export JAVA_HOME=${JAVA_HOME}

# Location of Hadoop.  By default, Hadoop will attempt to determine
# this location based upon its execution path.
# export HADOOP_HOME=

# Location of Hadoop's configuration information.  i.e., where this
# file is living. If this is not defined, Hadoop will attempt to
# locate it based upon its execution path.
#
# NOTE: It is recommend that this variable not be set here but in
# /etc/environment or equivalent.  Some options (such as
# --config) may react strangely otherwise.
#
# export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop

# The maximum amount of heap to use (Java -Xmx).  If no unit
# is provided, it will be converted to MB.  Daemons will
# prefer any Xmx setting in their respective _OPT variable.
# There is no default; the JVM will autoscale based upon machine
# memory size.
# export HADOOP_HEAPSIZE_MAX=

# The minimum amount of heap to use (Java -Xms).  If no unit
# is provided, it will be converted to MB.  Daemons will
# prefer any Xms setting in their respective _OPT variable.
# There is no default; the JVM will autoscale based upon machine
# memory size.
# export HADOOP_HEAPSIZE_MIN=

# Enable extra debugging of Hadoop's JAAS binding, used to set up
# Kerberos security.
# export HADOOP_JAAS_DEBUG=true

# Extra Java runtime options for all Hadoop commands. We don't support
# IPv6 yet/still, so by default the preference is set to IPv4.
# export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true"
# For Kerberos debugging, an extended option set logs more information
# export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true -Dsun.security.krb5.debug=true -Dsun.security.spnego.debug"

# Some parts of the shell code may do special things dependent upon
# the operating system.  We have to set this here. See the next
# section as to why....
export HADOOP_OS_TYPE=${HADOOP_OS_TYPE:-$(uname -s)}

# Extra Java runtime options for some Hadoop commands
# and clients (i.e., hdfs dfs -blah).  These get appended to HADOOP_OPTS for
# such commands.  In most cases, this should be left empty and
# let users supply it on the command line.
# export HADOOP_CLIENT_OPTS=""

#
# A note about classpaths.
#
# By default, Apache Hadoop overrides Java's CLASSPATH
# environment variable.  It is configured such
# that it starts out blank with new entries added after passing
# a series of checks (file/dir exists, not already listed aka
# de-deduplication).  During de-deduplication, wildcards and/or
# directories are *NOT* expanded to keep it simple. Therefore,
# if the computed classpath has two specific mentions of
# a file (e.g., /a/b and /a/b), the last one added will be set.
# It also puts a priority on user-definable classpath elements.
#
# An additional, custom CLASSPATH. Site-wide configs should be
# handled via the shellprofile functionality, utilizing the
# hadoop_add_classpath function for greater control and much
# easier debugging.
#
# Similarly, end users should utilize ${HOME}/.hadooprc .
# Other examples:
# export HADOOP_CLASSPATH="/some/cool/path/on/your/machine"
# Add S3 libraries to Hadoop classpath
export HADOOP_CLASSPATH="/opt/hive/lib/hadoop-aws-3.3.4.jar:/opt/hive/lib/aws-java-sdk-bundle-1.12.367.jar:$HADOOP_CLASSPATH"

# Should HADOOP_CLASSPATH be first in the official CLASSPATH?
# export HADOOP_USER_CLASSPATH_FIRST="yes"

# If HADOOP_USE_CLIENT_CLASSLOADER is set, the classpath along
# with the main jar are handled by a separate isolated
# client classloader when 'hadoop jar' is utilized. These jar files
# are then passed to the MR ApplicationMaster distributed cache,
# so it is utilized. If it is set, HADOOP_CLASSPATH and
# HADOOP_USER_CLASSPATH_FIRST are ignored.
# export HADOOP_USE_CLIENT_CLASSLOADER=true

# HADOOP_CLIENT_CLASSLOADER_SYSTEM_CLASSES overrides the default definition of
# system classes for the client classloader when HADOOP_USE_CLIENT_CLASSLOADER
# is enabled. Names ending in '.' (period) are treated as package names, and
# names starting with a '-' are treated as negative matches. For example,
# export HADOOP_CLIENT_CLASSLOADER_SYSTEM_CLASSES="-org.apache.hadoop.thirdparty.guava.,java.,javax.,org.apache.commons.logging"

# Enable optional, bundled Hadoop features
# This is a comma delimited list.  It may NOT be overridden via .hadooprc
# Entries may be added/removed as needed.
# export HADOOP_OPTIONAL_TOOLS="hadoop-aliyun,hadoop-aws,hadoop-azure,hadoop-azure-datalake,hadoop-google-cloud-storage,hadoop-kafka,hadoop-openstack"

#
# Options for remote shell connectivity
#
# There are several different now-deprecated ways to define these.
# This is the standard, preferred way.
#
# export HADOOP_SSH_OPTS="-o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=10s"

# ***  DEPRECATED  ***
# This is the older, deprecated way of setting these values.  All of
# these are equivalent to setting HADOOP_SSH_OPTS as above.
#
# export HADOOP_SSH_PARALLEL=10
# export HADOOP_SSH_SLEEP=0.1

#
# Options for all daemons
#
#

#
# Many options may also be specified as Java properties.  It is
# very common, and in many cases, desirable, to hard-set these
# in daemon _OPTS variables.  Where applicable, the appropriate
# Java property is also identified.  Note that many are re-used
# or set differently in certain contexts (e.g., secure vs
# non-secure)
#

# Process priority level
# export HADOOP_NICENESS=0

# Default log directory & file
export HADOOP_LOG_DIR="$HADOOP_HOME/logs"
export HADOOP_LOGFILE=hadoop.log

# Default log level and audit level
export HADOOP_LOGLEVEL=INFO
export HADOOP_AUDITLOGLEVEL=INFO

# Default policy file for service-level authorization
export HADOOP_POLICYFILE="hadoop-policy.xml"

# Turn on JVM JMX monitoring via the following two lines
# export HADOOP_JMX_BASE="-Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
# export HADOOP_JMX_BASE="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.port=8004"

# Some parts of the shell code may do special things dependent upon
# the operating system.  We have to set this here. See the next
# section as to why....
export HADOOP_OS_TYPE=${HADOOP_OS_TYPE:-$(uname -s)}

# Under certain conditions, Java on OS X will throw SCDynamicStore errors
# in the system logs.
# See HADOOP-8719 for more information.  If one needs Hadoop to
# access LDAP/etc directory information via JAAS, those errors might be
# important to track down. Otherwise, System.setProperty() stops the noise.
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true"
case ${HADOOP_OS_TYPE} in
  Darwin*)
    export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.realm= "
    export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.kdc= "
    export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.conf= "
  ;;
esac

# Extra SSH options.  Empty by default.
# This can be useful to pass authentication-related options to SSH
# (e.g., -o PasswordAuthentication=no) when password SSH is not possible,
# but there are no SSH keys set up.
export HADOOP_SSH_OPTS

#
# Options for all daemons
#

#
# Directory where PID files are stored.  /tmp by default.
# Some installations will want to put this somewhere more appropriate.
# NOTE: this should be set to a directory that can only be written to by
#       the users that will be executing the daemons.  Otherwise, there is
#       the potential for a symlink attack.
export HADOOP_PID_DIR=${HADOOP_PID_DIR:-/tmp}
export HADOOP_SECURE_PID_DIR=${HADOOP_SECURE_PID_DIR:-${HADOOP_PID_DIR}}

#
# A string representing this instance of hadoop. $USER by default.
# This is used to make sure that multiple instances of hadoop running on the
# same machine will use different log and pid files.
export HADOOP_IDENT_STRING=$USER

#
# The scheduling priority for daemons. Defaults to 0.
export HADOOP_NICENESS=${HADOOP_NICENESS:-0}

#
# Default log directory & file
export HADOOP_LOG_DIR="$HADOOP_HOME/logs"
export HADOOP_LOGFILE=hadoop.log

#
# File naming remote slave hosts.  $HADOOP_HOME/etc/hadoop/slaves by default.
export HADOOP_SLAVES=${HADOOP_HOME}/etc/hadoop/slaves

#
# host:path where hadoop code should be rsync'd from.  Unset by default.
export HADOOP_MASTER=

#
# Seconds to sleep between slave commands.  Unset by default.  This
# can be useful in large clusters, where, e.g., slave rsyncs can
# otherwise arrive faster than the master can service them.
export HADOOP_SLAVE_SLEEP=0.1

#
# The directory where pid files are stored. /tmp by default.
# NOTE: this should be set to a directory that can only be written to by
#       the users that will be executing the daemons.  Otherwise, there is
#       the potential for a symlink attack.
export HADOOP_PID_DIR=${HADOOP_PID_DIR:-/tmp}
export HADOOP_SECURE_PID_DIR=${HADOOP_SECURE_PID_DIR:-${HADOOP_PID_DIR}}

#
# A string representing this instance of hadoop. $USER by default.
# This is used to make sure that multiple instances of hadoop running on the
# same machine will use different log and pid files.
export HADOOP_IDENT_STRING=$USER

#
# The scheduling priority for daemons. Defaults to 0.
export HADOOP_NICENESS=${HADOOP_NICENESS:-0}

#
# Add database libraries to CLASSPATH
# The default is no database libraries are added. NOTE: if one exists,
# users may want to put other database connector jars in this directory as well.
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$HADOOP_HOME/share/hadoop/tools/lib/*

# Setting path to hdfs command for the datanode
export HDFS_DATANODE_HDFS=${HDFS_DATANODE_HDFS:-${HADOOP_HOME}/bin/hdfs}

#
# Options for remote shell connectivity
#
export HADOOP_SSH_OPTS="-o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=10s"

###
# Generic settings for DAEMON_USER
###

# Where (primarily) daemon log files are stored.  $HADOOP_HOME/logs by default.
# Java property: hadoop.log.dir
export HADOOP_LOG_DIR=${HADOOP_LOG_DIR:-$HADOOP_HOME/logs}

# A string representing this instance of hadoop. $USER by default.
# This is used to make sure that multiple instances of hadoop running on the
# same machine will use different log and pid files.
# Java property: hadoop.id.str
export HADOOP_IDENT_STRING=${HADOOP_IDENT_STRING:-$USER}

# How many seconds to pause after stopping a daemon
export HADOOP_STOP_TIMEOUT=${HADOOP_STOP_TIMEOUT:-5}

# Where pid files are stored.  $HADOOP_HOME/pids by default.
export HADOOP_PID_DIR=${HADOOP_PID_DIR:-$HADOOP_HOME/pids}

# Default log level and audit level
export HADOOP_ROOT_LOGGER=${HADOOP_ROOT_LOGGER:-"INFO,console"}
export HADOOP_DAEMON_ROOT_LOGGER=${HADOOP_DAEMON_ROOT_LOGGER:-$HADOOP_ROOT_LOGGER}

# Default process priority level
# Note that sub-processes will also run at this level!
export HADOOP_NICENESS=${HADOOP_NICENESS:-0}

# Default name for the service level authorization file
export HADOOP_POLICYFILE=${HADOOP_POLICYFILE:-"hadoop-policy.xml"}

#
# NOTE: this is not used by default!  <-----  NOTE NOTE NOTE
# You can define variables right here and then re-use them to avoid
# duplication.  For example, it is common to use the same garbage collection
# settings for all the daemons.  For each daemon, one can then use:
# export HADOOP_<DAEMON>_OPTS="${HADOOP_GC_SETTINGS} -Xloggc:${HADOOP_LOG_DIR}/<DAEMON>-gc-%p-%t.log"
#
# Generic settings for control over JVM(s).  Specific options for individual
# daemons are set below, if that daemon is configured to run via this
# generic prcoess
#

# default ulimit -n value
export HADOOP_SHELL_SCRIPT_DEBUG=${HADOOP_SHELL_SCRIPT_DEBUG:-false}

# Enable build debugging.  Replace with the build of Hadoop
# that was compiled with debugging symbols and/or additional
# tests.
# export HADOOP_ENABLE_BUILD_PATHS="true"