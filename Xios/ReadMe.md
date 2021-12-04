# System building

When generating MPM.SYS using GENSYS.COM, specify:
Top page of operating system (FF) ?
Number of TMPs (system consoles) (#4) ? 2
Number of Printers (#1) ?
Breakpoint RST (06) ?
Enable Compatibility Attributes (N) ? y
Add system call user stacks (Y) ?
Z80 CPU (Y) ?
Number of ticks/second (#60) ? 32
System Drive (A:) ?
Temporary file drive (A:) ?
Maximum locked records/process (#16) ?
Total locked records/system (#32) ?
Maximum open files/process (#16) ?
Total open files/system (#32) ?
Bank switched memory (Y) ?
Number of user memory segments (#3) ? 7
Common memory base page (C0) ? b0
Dayfile logging at console (Y) ? n
