# A Fedora Package for ActiveMQ Artemis

## Target user experience

    # Install the package
    $ sudo dnf install activemq-artemis

    # Start the server
    $ sudo systemctl start artemis

    $ sudo systemctl status artemis
    ● artemis.service - Apache ActiveMQ Artemis
       Loaded: loaded (/usr/lib/systemd/system/artemis.service; disabled; vendor preset: disabled)
       Active: active (running) since Mon 2017-04-17 16:48:32 PDT; 2s ago
     Main PID: 1491 (java)
        Tasks: 62 (limit: 4915)
       CGroup: /system.slice/artemis.service
               └─1491 java -XX:+PrintClassHistogram -XX:+UseG1GC -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -Xms512M [...]

    # Install artemis as an always-on service
    $ sudo systemctl enable artemis

    # Access the server logs
    $ journalctl -u artemis -f
    -- Logs begin at Sat 2016-12-24 17:16:41 PST. --
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,318 INFO  [org.apache.activemq.artemis.core.server] AMQ221003: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,576 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,578 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,579 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,585 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,587 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,591 INFO  [org.apache.activemq.artemis.core.server] AMQ221007: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,591 INFO  [org.apache.activemq.artemis.core.server] AMQ221001: [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,778 INFO  [org.apache.activemq.artemis] AMQ241001: HTTP Server [...]
    Apr 17 16:48:33 localhost.localdomain artemis[1491]: 16:48:33,778 INFO  [org.apache.activemq.artemis] AMQ241002: Artemis Jol [...]

    # Query the package details
    $ rpm -qi activemq-artemis
    Name        : activemq-artemis
    Version     : 0
    Release     : 0.1.20170414.09958aa5.fc25
    Architecture: x86_64
    Install Date: Fri 14 Apr 2017 08:30:02 AM PDT
    Group       : System Environment/Daemons
    Size        : 47729949
    License     : ASL 2.0
    Signature   : RSA/SHA1, Fri 14 Apr 2017 08:00:32 AM PDT, Key ID 2e6ad057dda7ac49
    Source RPM  : activemq-artemis-0-0.1.20170414.09958aa5.fc25.src.rpm
    Build Date  : Fri 14 Apr 2017 08:00:21 AM PDT
    Build Host  : copr-builder-435276744.novalocal
    Relocations : (not relocatable)
    Vendor      : Fedora Project COPR (jross/ssorj)
    URL         : https://activemq.apache.org/artemis/
    Summary     : A multi-protocol message broker
    Description :
    Apache ActiveMQ Artemis is a multi-protocol, embeddable, high
    performance, clustered, asynchronous message broker

    # Uninstall the package
    $ sudo dnf remove activemq-artemis

## Installation

Test RPMs are available for Fedora 24 and 25.

    $ sudo dnf copr enable jross/ssorj
    $ sudo dnf install activemq-artemis

To build your own RPM locally:

    $ cd activemq-artemis-rpm/
    $ make clean test
    [...]
    Output: /home/jross/code/activemq-artemis-rpm/build/RPMS/x86_64/activemq-artemis-0-0.1.20170417.09958aa5.fc25.x86_64.rpm
    $ sudo dnf install /home/jross/code/activemq-artemis-rpm/build/RPMS/x86_64/activemq-artemis-0-0.1.20170417.09958aa5.fc25.x86_64.rpm

## Philosophy

This packaging of Artemis takes the view that its implementation
language is not important.  Instead, it's the network service,
configuration files, and command-line tools that matter because they
are the primary points of user interaction in a typical server
deployment.

Files are moved into standard Linux locations.  A default system
instance is registered with systemd and ready for immediate use.  The
system instance executable is installed on the path.

## File locations

 - /etc/artemis - System instance configuration files
 - /usr/bin/artemis - The system instance executable
 - /usr/lib64/artemis - Read-only Artemis code and resources
 - /var/lib/artemis - The default system instance
 - /var/log/artemis - System instance log files
 - /var/tmp/artemis - System instance temporary files
 - /usr/lib/systemd/system/artemis.service - The systemd service file

## More topics to address

 - Make targets
 - Avoiding static web docs in the package
 - A new server script
   - No sed surgery
   - Synchronous stop
   - Better signal handling
   - Dynamic configuration
 - Initial security configuration
 - An SELinux policy
 - Remove libraries not required for brokerness

## Notes

### Build fails on EL 7

    [WARNING] Rule 0: org.apache.maven.plugins.enforcer.RequireMavenVersion failed with message:
    Detected Maven Version: 3.0.5 is not in the allowed range 3.1.

### Miscellaneous

    sudo runuser -u artemis artemis run
