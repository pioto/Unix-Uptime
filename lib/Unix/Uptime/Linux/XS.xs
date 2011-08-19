#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

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
        struct sysinfo si;
    PPCODE:
        if (-1 == sysinfo(&si)) {
            croak("sysinfo: %s", strerror(errno));
        }
        EXTEND(SP, 3);
        PUSHs(sv_2mortal(newSViv(si.loads[0]>>(SI_LOAD_SHIFT))));
        PUSHs(sv_2mortal(newSViv(si.loads[1]>>(SI_LOAD_SHIFT))));
        PUSHs(sv_2mortal(newSViv(si.loads[2]>>(SI_LOAD_SHIFT))));

