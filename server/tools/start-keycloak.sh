#!/bin/bash

if [ -z "$KEYCLOAK_CUSTOM_PATH" ]; then
    echo "No custom path specified"
else
    # Modify base path for keycloak
    echo "Using /$KEYCLOAK_CUSTOM_PATH for keycloak"
    sed -i -e "s:<web-context>auth<\/web-context>:<web-context>$KEYCLOAK_CUSTOM_PATH\/auth<\/web-context>:" $JBOSS_HOME/standalone/configuration/standalone.xml
    sed -i -e "s:<web-context>auth<\/web-context>:<web-context>$KEYCLOAK_CUSTOM_PATH\/auth<\/web-context>:" $JBOSS_HOME/standalone/configuration/standalone-ha.xml
    sed -i -e "s:name=\"/\":name=\"/$KEYCLOAK_CUSTOM_PATH/\":" $JBOSS_HOME/standalone/configuration/standalone.xml
    sed -i -e "s:name=\"/\":name=\"/$KEYCLOAK_CUSTOM_PATH/\":" $JBOSS_HOME/standalone/configuration/standalone-ha.xml
    sed -i -e "s:\/auth:\/$KEYCLOAK_CUSTOM_PATH\/auth:" $JBOSS_HOME/welcome-content/index.html
    sed -i -e "s:<web-context>auth<\/web-context>:<web-context>$KEYCLOAK_CUSTOM_PATH\/auth<\/web-context>:" $JBOSS_HOME/domain/configuration/domain.xml
fi

# Run keycloak
./opt/jboss/tools/docker-entrypoint.sh -b 0.0.0.0