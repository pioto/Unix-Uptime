#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <string.h>
#include <sys/param.h>
#include <sys/sysctl.h>

MODULE = Unix::Uptime::BSD::XS PACKAGE = Unix::Uptime::BSD::XS

void
sysctl_kern_boottime()
    INIT:
        int mib[2] = { CTL_KERN, KERN_BOOTTIME };
        struct timeval boottime;
        size_t len = sizeof(boottime);
    PPCODE:
        if (-1 == sysctl(mib, 2, &boottime, &len, NULL, 0)) {
            croak("sysctl: %s", strerror(errno));
        }
        EXTEND(SP, 2);
        PUSHs(sv_2mortal(newSViv(boottime.tv_sec)));
        PUSHs(sv_2mortal(newSViv(boottime.tv_usec)));

