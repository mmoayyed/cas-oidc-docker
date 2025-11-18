# How to build

Apereo CAS server is typically built with Apache Maven or Gradle. These are build tools that one can use to generate a CAS web application from an existing installation. 

First, you must locate where your CAS installation directory is. This is the directory that contains either `pom.xml` file (if your server is built with Apache Maven) or a `build.gradle` file (if your server is built with Gradle).

## Java 11

Your build server that hosts the CAS server must have Java 11 installed already. You can download a compatible JDK 11 distribution from any of the JDK providers, such as Azul, Amazon Corretto, etc.

## Apache Maven

If your CAS server is built with Apache Maven, you typically need to download and install Apache Maven from here: https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.zip 

Download and unzip the file into a directory, i.e. `/opt/apache-maven` and make sure you can execute the `mvn` command from that directory: `/opt/apache-maven/bin/mvn --version`. 

If you're building on Windows, make sure to execute the `/opt/apache-maven/bin/mvn.bat --version` instead. 

This step is only required if your CAS server is built with Apache Maven and you can locate a `pom.xml` file inside the main CAS server directory where installation files are located. i.e. `/opt/cas-server`. 

## Gradle

If your CAS server is built with Gradle, you do not need to download Gradle separately. It should come with the installation already.

This step is only required if your CAS server is built with Gradle and you can locate a `build.gradle` file inside the main CAS server directory where installation files are located. i.e. `/opt/cas-server`. You should be able to execute this command `./gradlew --version` from inside the CAS directory. 

If you're building on Windows, make sure to execute the `./gradlew.bat --version` instead. 