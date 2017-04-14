# Fedora Package for ActiveMQ Artemis

## Topics

 - Target user experience
 - Philosophy
 - Default system instance
 - File locations
 - Make targets
 - Avoiding static web docs in the package
 - A new server script
   - No sed surgery
   - Synchronous stop
   - Better signal handling
   - Dynamic configuration
 - Initial security configuration
 - An SELinux policy

## Notes

### Build fails on EL 7

    [WARNING] Rule 0: org.apache.maven.plugins.enforcer.RequireMavenVersion failed with message:
    Detected Maven Version: 3.0.5 is not in the allowed range 3.1.

### Miscellaneous

    sudo runuser -u artemis artemis run
