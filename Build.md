# How to build

Apereo CAS server is typically built with Apache Maven or Gradle. These are build tools that one can use to generate a CAS web application from an existing installation. 

First, you must locate where your CAS installation directory is. This is the directory that contains either `pom.xml` file (if your server is built with Apache Maven) or a `build.gradle` file (if your server is built with Gradle).

**Note**: an active internet connection is required on the machine that builds the CAS server.

## Java 11

Your build server that hosts the CAS server must have Java 11 installed already. You can download a compatible JDK 11 distribution from any of the JDK providers, such as Azul, Amazon Corretto, etc.

## Apache Maven

If your CAS server is built with Apache Maven, you typically need to download and install Apache Maven from here: https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.zip 

Download and unzip the file into a directory, i.e. `/opt/apache-maven` and make sure you can execute the `mvn` command from that directory: `/opt/apache-maven/bin/mvn --version`. 

If you're building on Windows, make sure to execute the `/opt/apache-maven/bin/mvn.bat --version` instead. 

This step is only required if your CAS server is built with Apache Maven and you can locate a `pom.xml` file inside the main CAS server directory where installation files are located. i.e. `/opt/cas-server`. 

Next, locate your `/opt/cas-server/pom.xml` file and locate the `<dependencies>` top-level tag.

Add the following block inside this tag:

```xml
<dependency>
    <groupId>org.apereo.cas</groupId>
    <artifactId>cas-server-support-oidc</artifactId>
    <version>YOUR_CAS_VERSION</version>
</dependency>
```

Change `YOUR_CAS_VERSION` to match your CAS version. This should be THE SAME for all other `dependency` blocks in the same file. i.e. `6.2.8`.

Then, execute this command:

```bash
cd /opt/cas-server
/opt/apache-maven/bin/mvn clean package
```

If you're on Windows:

```bash
cd /opt/cas-server
/opt/apache-maven/bin/mvn.bat clean package
```

You should see a `BUILD SUCCESS` at the end of this command. The generated CAS server is available at `/opt/cas-server/target/cas.war`

## Gradle

If your CAS server is built with Gradle, you do not need to download Gradle separately. It should come with the installation already.

This step is only required if your CAS server is built with Gradle and you can locate a `build.gradle` file inside the main CAS server directory where installation files are located. i.e. `/opt/cas-server`. You should be able to execute this command `./gradlew --version` from inside the CAS directory. 

If you're building on Windows, make sure to execute the `./gradlew.bat --version` instead. 

Next, locate your `/opt/cas-server/build.gradle` file and locate the `dependencies` top-level tag.

Add the following block inside this tag:

```groovy
dependencies {
    // ONLY add the line below....
    implementation "org.apereo.cas:cas-server-support-oidc:YOUR_CAS_VERSION"
}
```

Change `YOUR_CAS_VERSION` to match your CAS version. This should be THE SAME for all other entries in the same file. i.e. `6.2.8`.

Then, execute this command:

```bash
cd /opt/cas-server
/.gradlew clean build
```

If you're on Windows:

```bash
cd /opt/cas-server
./gradlew.bat clean build
```

You should see a `BUILD SUCCESS` at the end of this command. The generated CAS server is available at `/opt/cas-server/build/libs/cas.war`

# Register Traccar Application

The Traccar application needs to be registered with CAS first. Typically applications are registered with CAS using simple JSON files and these files are usually found inside the `/etc/cas/services` directory or on Windows, this would be `c:\etc\cas\services`. 

If you cannot locate this directory, you should confirm its location by looking at `c:\etc\cas\config\cas.properties` file or `/etc/cas/config/cas.properties` file. In this file, you should spot the following property:

```properties
cas.service-registry.json.location=...
```

The `...` should tell you where the application registration records are located. If you cannot locate the `cas.properties` file at that location or if the setting is not found inside that file, then the CAS server is using a different way of registering applications and the configuration altogether needs to be reviewed with an expert.

Assuming you found this directory, i.e. `/etc/cas/services`, create a `Traccar-1.json` file inside it. Paste the following inside this file:

```json
{
  "@class" : "org.apereo.cas.services.OidcRegisteredService",
  "clientId": "...",
  "clientSecret": "...",
  "bypassApprovalPrompt" : true,
  "serviceId" : "^http.+/api/session/openid/callback",
  "name": "Traccar",
  "id": 1,
  "scopes" : [ "java.util.HashSet", [ "profile", "email", "address", "phone" ]
  ]
}
```

Note:

- You should create your own client ID and client secret.  Generate your own values and share them with the Traccar application owners. These values could be any simple random value, i.e `b6fhg54jdbvk9`

- You MUST make sure your CAS server is fetching these attributes from the attribute source: `name`, `email`, `email_verified`. The first two are most important. If your user attributes come from LDAP, you MUST make sure the LDAP configuration is fetching these attributes, and you must have them available for all users in LDAP.

Now you should be able to deploy the CAS web application (the .war file that was generated earlier) and restart it. 