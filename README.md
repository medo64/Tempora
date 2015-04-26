### Tempora ###

Quick and dirty NTP server.

As any program that is written in one afternoon, this one has fair share of
things not done. First of all, this program was only tested with Windows XP and
Windows 7 as clients. While other versions should work, I spent no time in
actually testing it.

This server is also not fully NTP compliant. All fields are there and all
clients will consider it valid time source but stratum, precision, root delay
and root dispersion numbers are just hard-coded instead of calculated. This
should present no trouble in local network and if precision in seconds is
satisfactory, but it is definitely not time server you would use if every
microsecond is important.

You will need to **disable** Windows Time service for this program to work.
Both require same port and are bad in sharing.
