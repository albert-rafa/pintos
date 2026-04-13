#include "userprog/syscall.h"
#include <stdio.h>
#include <syscall-nr.h>
#include <console.h>
#include "threads/interrupt.h"
#include "threads/thread.h"

static void syscall_handler (struct intr_frame *);

void
syscall_init (void) 
{
  intr_register_int (0x30, 3, INTR_ON, syscall_handler, "syscall");
}

// Writes size bytes from buffer to the open file ffd. Returns the number of bytes actually written. fd 1 writes to the console.
static int write (int fd, const void *buffer, unsigned size) {
  if (fd == 1) {
    putbuf(buffer, size);
    return size;
  }

  // TODO: (fd != 1) -> Writes on file 

  return -1;
}

// Waits for a child process (thread) tid and retrieves the child's exit status.
static int wait (tid_t tid) {
  printf("\n[SYS_WAIT] Esperando pelo processo de id '%d' terminar.\n", tid);

  int status = 0; // sucesso
  return status;
}

// Terminates the current user program, returning status to the kernel. If the process's parent waits for it, this is 
// the status that will be returned. Convenrionally, a status of 0 indicates success and nonzero values indicates
// errors.
static void exit (int status) {
  struct thread *cur = thread_current();

  cur->exit_status = status; // Usar no wait()
  if (cur->parent != NULL) sema_up(&cur->wait_sema);

  printf("%s: exit(%d)\n", cur->name, status);

  thread_exit();
}

static void
syscall_handler (struct intr_frame *f) 
{
  int *args = (int*)f->esp;
  switch (args[0]) {
    case SYS_WRITE:
      f->eax = write(args[1], (const void *) args[2], (unsigned) args[3]);
      break;
    case SYS_WAIT:
      wait(999);
      break;
    case SYS_EXIT:
      exit(args[1]);
      break;
  }

  // printf("\n[syscall] syscall = %s\n", get_syscall_label(args[0]));
}

