#!/bin/sh
cd `dirname $0`
g_string_appname=""
g_string_symname=""
g_string_dumpid=""
g_string_arch="arm64"
g_string_dsymname=""

doProcess()
{
    filelistStr=`find *.dSYM`

    if [ "$g_string_dsymname" = "" ]
    then
        for filename in $filelistStr
        do
            g_string_dsymname=$filename
            break
        done
    fi

    echo $g_string_dsymname

    g_string_appname=$(echo $g_string_dsymname | awk '{split($0,arr,"." ); print arr[1]}')
    g_string_symname=${g_string_appname}.sym

    has_sym_file="FALSE"
    sym_file_list=`find *.sym`
    for symfile in $sym_file_list
    do
        if [ "$symfile" = "$g_string_symname" ]
        then
            has_sym_file="TRUE"
        fi
    done

    #导出.dSYM中的符号到 .sym文件中
    if [ "$has_sym_file" = "FALSE" ]
    then
        ./dump_syms -a $g_string_arch "$g_string_dsymname" > "$g_string_symname"
    fi

    #获取文件的第一行
    headline=`head -n 1 "$g_string_symname"`
    #获取dump id
    g_string_dumpid=$(echo $headline | awk '{ print $4; }')
    rm -rf symbols
    mkdir -p symbols/"$g_string_appname"/$g_string_dumpid/
    cp "$g_string_symname" symbols/"$g_string_appname"/$g_string_dumpid/
    rm -f $g_string_symname
}




until [ $# -eq 0 ]
do
    case $1 in
        -a )
        g_string_arch=$2
        shift
            ;;
        -s )
        g_string_dsymname=$2
        shift
            ;;
    *)
    echo "error: unknow args $1"
     ;;
    esac
    shift
done

doProcess





