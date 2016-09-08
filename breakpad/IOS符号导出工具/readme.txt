1.将 .dSYM 文件拷贝到当前目录
2.运行命令：./export_sym.sh -a [架构] -s [dSYM 文件名]  （如果.dSYM文件名有空格，必须手动指定文件名，如果没有空格，可以不指定）

如果 报错，先设置权限 命令 
chmod 777 dump_syms文件的完整路径
chmod 777 minidump_stackwalk文件的完整路径