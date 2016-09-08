#!/bin/sh
cd `dirname $0`
g_string_file_so=""
g_string_file_sym=""
g_string_dumpid=""
filelistStr=`find *.so`
for filename in $filelistStr
do
	g_string_file_so=$filename
    g_string_file_sym=${g_string_file_so}.sym

    has_sym_file="FALSE"
    sym_file_list=`find *.sym`
    for symfile in $sym_file_list
    do
        if [ "$symfile" = "$g_string_file_sym" ]
        then
            has_sym_file="TRUE"
        fi
    done

    #导出.so中的符号到 .sym文件中
    if [ "$has_sym_file" = "FALSE" ]
    then
        ./dump_syms $g_string_file_so > $g_string_file_sym
    fi

    #获取文件的第一行
    headline=`head -n 1 $g_string_file_sym`
    #获取dump id
    g_string_dumpid=$(echo $headline | awk '{ print $4; }')
    rm -rf symbols
    mkdir -p symbols/$g_string_file_so/$g_string_dumpid/
    cp $g_string_file_sym symbols/$g_string_file_so/$g_string_dumpid/
    rm -f $g_string_file_sym
    break
done