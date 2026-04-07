#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Apache Maven Wrapper startup batch script, version 3.3.4
#
# Optional ENV vars
# -----------------
#   JAVA_HOME - location of a JDK home dir, required when type is not auto
#   MVNW_REPOURL - repo url base for downloading maven distribution
#   MVNW_USERNAME/MVNW_PASSWORD - user and password for downloading maven
#   MVNW_VERBOSE - true: enable verbose log; others: silence the script
# ----------------------------------------------------------------------------

set -euf
[ "${MVNW_VERBOSE-}" != true ] || set -x

# OS specific support.
native_path() { printf %s\\n "$1"; }
case "$(uname)" in
CYGWIN* | MINGW*)
  [ -z "${JAVA_HOME-}" ] || JAVA_HOME="$(cygpath --unix "$JAVA_HOME")"
  native_path() { cygpath --path --windows "$1"; }
  ;;
esac

# set JAVACMD and JAVACMD_ARGS
set_java_home() {
  # For Cygwin and MinGW, ensure paths are in Unix format before anything is touched
  if [ -n "${JAVA_HOME-}" ]; then
    if [ -x "$JAVA_HOME/jre/sh/java" ]; then
      # IBM's JDK on AIX uses strange locations for the executables
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ]; then
      die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
  else
    JAVACMD="$(
      'set' +e
      'unset' -v JAVA_TOOL_OPTIONS
      'java' -version >"/dev/null" 2>&1 && echo java || :
    )"
    [ -n "$JAVACMD" ] || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
  fi
}

# In POSIX sh, 'local' is undefined. There are no built-in alternatives.
# shellcheck disable=SC2039,SC3043
die() {
  printf '%s\n' "$@" >&2
  exit 1
}

# sha256sum is preferred, but md5sum is also acceptable
if ! command -v unzip >/dev/null; then
  die "ERROR: unzip not found"
  exit 1
fi

if [ "${MVNW_VERBOSE-}" = debug ]; then
  : # do nothing
fi

# Path to Apache Maven Wrapper properties file
MAVEN_WRAPPER_PROPERTIES_PATH="$(dirname "$0")/.mvn/wrapper/maven-wrapper.properties"

if [ -r "$MAVEN_WRAPPER_PROPERTIES_PATH" ]; then
  # shellcheck source=/dev/null
  . "$MAVEN_WRAPPER_PROPERTIES_PATH"
fi

# Default MVNW_REPOURL to the value from the properties file or default value
MVNW_REPOURL="${MVNW_REPOURL:-${distributionUrl:-}}"
MVNW_REPOURL="${MVNW_REPOURL:-https://repo.maven.apache.org/maven2}"

# Prefix $MVNW_REPOURL with a slash if not already present
case "$MVNW_REPOURL" in
/*) ;;
*) MVNW_REPOURL="/$MVNW_REPOURL" ;;
esac

MAVEN_WRAPPER_JAR="$(dirname "$0")/.mvn/wrapper/maven-wrapper.jar"
MAVEN_WRAPPER_DOWNLOADER="$(dirname "$0")/.mvn/wrapper/MavenWrapperDownloader.java"

# Determine the Maven distribution URL
distributionUrl="${distributionUrl:-https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.14/apache-maven-3.9.14-bin.zip}"

# Find the Java executable
set_java_home

# Check if the Maven wrapper jar already exists
if [ -r "$MAVEN_WRAPPER_JAR" ]; then
  : # Use the jar directly
elif [ -r "$MAVEN_WRAPPER_DOWNLOADER" ]; then
  # If downloader script exists, compile and run it
  "$JAVACMD" "$MAVEN_WRAPPER_DOWNLOADER" "$distributionUrl" "$MAVEN_WRAPPER_JAR"
fi

MAVEN_HOME="$HOME/.m2/wrapper/dists/$(basename "$distributionUrl" .zip)"
MAVEN_EXEC="$MAVEN_HOME/bin/mvn"

if [ ! -x "$MAVEN_EXEC" ]; then
  # Download and extract Maven if not already present
  MAVEN_ZIP="$HOME/.m2/wrapper/dists/$(basename "$distributionUrl")"
  mkdir -p "$(dirname "$MAVEN_ZIP")"
  if command -v wget >/dev/null; then
    wget -q "$distributionUrl" -O "$MAVEN_ZIP" || die "ERROR: Failed to download Maven from $distributionUrl"
  elif command -v curl >/dev/null; then
    curl -fsSL "$distributionUrl" -o "$MAVEN_ZIP" || die "ERROR: Failed to download Maven from $distributionUrl"
  else
    die "ERROR: Neither wget nor curl found. Please install one of them."
  fi
  unzip -q "$MAVEN_ZIP" -d "$(dirname "$MAVEN_HOME")" || die "ERROR: Failed to unzip Maven distribution"
  rm -f "$MAVEN_ZIP"
fi

exec "$MAVEN_EXEC" "$@"
