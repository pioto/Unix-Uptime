#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdlib.h>
#include <string.h>
#include <sys/sysinfo.h>

MODULE = Unix::Uptime::Linux::XS PACKAGE = Unix::Uptime::Linux::XS

void
sysinfo_uptime()
    INIT:
        struct sysinfo si;
    PPCODE:
        if (-1 == sysinfo(&si)) {
            croak("sysinfo: %s", strerror(errno));
        }
        EXTEND(SP, 1);
        PUSHs(sv_2mortal(newSViv(si.uptime)));

void
sysinfo_loads()
    INIT:
        double loadavg[3];
    PPCODE:
        if (-1 == getloadavg(&loadavg, 3)) {
            croak("getloadavg: %s", strerror(errno));
        }
        EXTEND(SP, 3);
        PUSHs(sv_2mortal(newSViv(loadavg[0])));
        PUSHs(sv_2mortal(newSViv(loadavg[1])));
        PUSHs(sv_2mortal(newSViv(loadavg[2])));

