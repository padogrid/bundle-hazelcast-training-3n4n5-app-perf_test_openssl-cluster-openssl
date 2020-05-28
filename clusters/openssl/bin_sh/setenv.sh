#
# Add cluster specific environment variables in this file.
#

# Set Java options, i.e., -Dproperty=xyz
#JAVA_OPTS=

# To use Hibernate backed MapStorePkDbImpl, set the following property and
# configure MapStorePkDbImpl in the $CLUSTER_DIR/etc/hazelcast.xml file.
# MySQL and PostgreSQL Hibernate configuration files are provided to get
# you started. You should copy one of them and enter your DB information.
# You can include your JDBC driver in the ../pom.xml file and run ./build_app
# which downloads and places it in the $HAZELCAST_ADDON_WORKSPACE/lib
# directory. CLASSPATH includes all the jar files in that directory for
# the apps and clusters running in this workspace.
#JAVA_OPTS="$JAVA_OPTS -Dhazelcast-addon.hibernate.config=$CLUSTER_DIR/etc/hibernate.cfg-mysql.xml"
#JAVA_OPTS="$JAVA_OPTS -Dhazelcast-addon.hibernate.config=$CLUSTER_DIR/etc/hibernate.cfg-postgresql.xml"

TRUST_CERT_COLLECTION_FILE=$CLUSTER_DIR/etc/ssl/lab.crt
KEY_FILE=$CLUSTER_DIR/etc/ssl/lab.key
KEY_CERT_CHAIN_FILE=$TRUST_CERT_COLLECTION_FILE

if [[ $OS_NAME == CYGWIN* ]]; then
   TRUST_CERT_COLLECTION_FILE=$(cygpath -wp "$TRUST_CERT_COLLECTION_FILE")
   KEY_FILE=$(cygpath -wp "$KEY_FILE")
   KEY_CERT_CHAIN_FILE=$(cygpath -wp "$KEY_CERT_CHAIN_FILE")
fi
   
JAVA_OPTS="$JAVA_OPTS \
-DtrustCertCollectionFile="$TRUST_CERT_COLLECTION_FILE" \
-DkeyFile="$KEY_FILE" \
-DkeyCertChainFile="$KEY_CERT_CHAIN_FILE" \
-Djavax.net.debug=SSL"

# Set Management Center Java options, i.e., -Dhazelcast.mc.forceLogoutOnMultipleLogin=true
#MC_JAVA_OPTS=

# Set RUN_SCRIPT. Absolute path required.
# If set, the 'start_member' command will run this script instead of com.hazelcast.core.server.StartServer.
# Your run script will inherit the following:
#    JAVA_OPTS - Java options set by hazelcast-addon.
#    CLASSPATH - Class path set by hazelcast-addon. You can include additional libary paths.
#                You should, however, place your library files in the plugins directories
#                if possible.
# Although it is not required, your script should be placed in the bin_sh directory.
#RUN_SCRIPT=$CLUSTER_DIR/bin_sh/your-script
