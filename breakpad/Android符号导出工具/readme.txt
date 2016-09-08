必须在linux环境下执行以下操作，可以是cygwin，也可以是虚拟机或者mac下的vagrant。

1.将Android带符号的动态库拷贝到当前目录。
  带符号的文件路径：Android工程根目录/obj/local/架构/主程序.so

 2.在终端运行export_sym.sh，将会在当前目录下生成符号文件
