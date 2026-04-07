@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    https://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM ----------------------------------------------------------------------------
@REM Apache Maven Wrapper startup batch script, version 3.3.4
@REM
@REM Optional ENV vars
@REM   MVNW_REPOURL - repo url base for downloading maven distribution
@REM   MVNW_USERNAME/MVNW_PASSWORD - user and password for downloading maven
@REM   MVNW_VERBOSE - true: enable verbose log; others: silence the script
@REM ----------------------------------------------------------------------------

@IF "%__MVNW_ARG0_NAME__%"=="" (SET "BASE_DIR=%~dp0") ELSE (SET "BASE_DIR=%__MVNW_ARG0_NAME__%")

@SET MAVEN_WRAPPER_PROPERTIES_PATH=%BASE_DIR%.mvn\wrapper\maven-wrapper.properties

@SET MVNW_VERBOSE=false

@IF "%MVNW_VERBOSE%"=="true" @ECHO ON

@REM Read the maven-wrapper.properties file
@FOR /F "usebackq tokens=1,2 delims==" %%a IN ("%MAVEN_WRAPPER_PROPERTIES_PATH%") DO @(
  @IF "%%a"=="distributionUrl" SET DISTRIBUTION_URL=%%b
)

@IF "%DISTRIBUTION_URL%"=="" SET "DISTRIBUTION_URL=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.14/apache-maven-3.9.14-bin.zip"

@REM Determine Maven home dir
@SET "MAVEN_DIST_NAME="
@FOR %%F IN ("%DISTRIBUTION_URL%") DO @SET "MAVEN_DIST_NAME=%%~nF"

@SET "MAVEN_HOME=%USERPROFILE%\.m2\wrapper\dists\%MAVEN_DIST_NAME%"
@SET "MAVEN_EXEC=%MAVEN_HOME%\bin\mvn.cmd"

@IF NOT EXIST "%MAVEN_EXEC%" (
  @SET "MAVEN_ZIP=%USERPROFILE%\.m2\wrapper\dists\%MAVEN_DIST_NAME%.zip"
  @IF NOT EXIST "%USERPROFILE%\.m2\wrapper\dists\" @MKDIR "%USERPROFILE%\.m2\wrapper\dists\"
  @IF EXIST "%SystemRoot%\System32\curl.exe" (
    @curl.exe -fsSL "%DISTRIBUTION_URL%" -o "%MAVEN_ZIP%"
  ) ELSE (
    @powershell -Command "Invoke-WebRequest -Uri '%DISTRIBUTION_URL%' -OutFile '%MAVEN_ZIP%'"
  )
  @powershell -Command "Expand-Archive -Path '%MAVEN_ZIP%' -DestinationPath '%USERPROFILE%\.m2\wrapper\dists\'"
  @DEL "%MAVEN_ZIP%"
)

@IF NOT EXIST "%MAVEN_EXEC%" (
  @ECHO ERROR: Failed to find or download Maven >&2
  @EXIT /B 1
)

@"%MAVEN_EXEC%" %*
