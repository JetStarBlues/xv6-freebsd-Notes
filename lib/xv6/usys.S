#include <xv6/syscall.h>
#include <xv6/traps.h>

.globl _exit
_exit:
     movl $SYS_exit, %eax
     int $T_SYSCALL
     testl   %eax, %eax
     js      .L5
     ret
.L5: negl    %eax
     movl    %eax, errno
     movl    $-1, %eax
     ret

.globl _Fstat
_Fstat:
     movl $SYS_fstat, %eax
     int $T_SYSCALL
     testl   %eax, %eax
     js      .L5
     ret

.globl _Time
_Time:
     movl $SYS_time, %eax
     int $T_SYSCALL
     testl   %eax, %eax
     js      .L5
     ret

.globl _Sleep
_Sleep:
     movl $SYS_sleep, %eax
     int $T_SYSCALL
     testl   %eax, %eax
     js      .L5
     ret

#define SYSCALL(name) \
.globl name; \
name: \
     movl $SYS_ ## name, %eax; \
     int $T_SYSCALL; \
     testl   %eax, %eax; \
     js      .L5; \
     ret

SYSCALL(fork)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(uptime)
SYSCALL(lseek)
SYSCALL(ioctl)
SYSCALL(fchdir)
