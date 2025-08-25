sudo bpftrace -e '
kfunc:vfs_write
/ str(args->file->f_path.dentry->d_name.name) == "in.txt" || str(args->file->f_path.dentry->d_name.name) == "out.txt" /
{
  printf("WRITE %-6d %-16s %-24s count=%d\n",
         pid, comm,
         str(args->file->f_path.dentry->d_name.name),
         args->count);
}

kfunc:vfs_read
/ str(args->file->f_path.dentry->d_name.name) == "in.txt" || str(args->file->f_path.dentry->d_name.name) == "out.txt" /
{
  printf("READ  %-6d %-16s %-24s count=%d\n",
         pid, comm,
         str(args->file->f_path.dentry->d_name.name),
         args->count);
}

tracepoint:syscalls:sys_enter_open
{
  $p = str(args->filename);

  if (strncmp($p, "in.txt", 6) == 0) {
    printf("OPENAT pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
  }

  if (strncmp($p, "out.txt", 7) == 0) {
    printf("OPENAT pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
  }
}

tracepoint:syscalls:sys_enter_openat
{
  $p = str(args->filename);

  if (strncmp($p, "in.txt", 6) == 0) {
    printf("OPENAT pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
  }

  if (strncmp($p, "out.txt", 7) == 0) {
    printf("OPENAT pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
  }
}

tracepoint:syscalls:sys_enter_openat2
{
  $p = str(args->filename);

  if (strncmp($p, "in.txt", 6) == 0) {
    printf("OPENAT2 pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
  }

  if (strncmp($p, "out.txt", 7) == 0) {
    printf("OPENAT pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
  }
}'

# tracepoint:syscalls:sys_enter_open
# {
#   $p = str(args->filename);
#   printf("OPEN pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
# }

# tracepoint:syscalls:sys_enter_openat
# {
#   $p = str(args->filename);
#   printf("OPENAT pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
# }

# tracepoint:syscalls:sys_enter_openat2
# {
#   $p = str(args->filename);
#   printf("OPENAT2 pid=%-6d comm=%-16s path=%s\n", pid, comm, $p);
# }

#kfunc:vfs_open
#/ str(args->file->f_path.dentry->d_name.name) == "in.txt" /
#{
#  printf ("OPENED INPUT %-6d %-16s %-24s\n", pid, comm, str(args->file->f_path.dentry->d_name.name));
#}

#kfunc:vfs_open
#/str(args->file->f_path.dentry->d_name.name) == "out.txt" / {
#  printf("OPENED OUTPUT %-6d %-16s %-24s\n", pid, comm, str(args->file->f_path.dentry->d_name.name));
#}
