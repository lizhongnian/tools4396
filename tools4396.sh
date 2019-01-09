#!/bin/bash
## 一键脚本合集
#定义颜色
red="\033[31m"
green='\033[32m'
yellow='\033[33m'
none='\033[0m'
# 打印欢迎信息
clear
echo "---------------------------------------------"
echo -e "  ${green}Install${none}：欢迎使用tools4396工具 "
echo -e "  ${green}Author${none}: 7colorblog"
echo -e "  ${green}URL${none}: https://www.7colorblog.com"
echo -e "  ${green}Article${none}: https://www.7colorblog.com/?id=64"
echo "---------------------------------------------"
echo ""
#检查是否root用户
check_root(){
	[ $(id -u) != "0" ] && {
		echo -e " ${red}Error ${none}：必须使用root用户执行此脚本！"; exit 1; 
	}
}
#获取uuid
get_uuid(){
	uuid=$(cat /proc/sys/kernel/random/uuid)
}
#获取本机ip
get_ip() {
	ip=$(curl -s https://ipinfo.io/ip)
}
#检查系统
check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
}
#检查Linux版本
check_version(){
	if [[ -s /etc/redhat-release ]]; then
		version=`grep -oE  "[0-9.]+" /etc/redhat-release | cut -d . -f 1`
	else
		version=`grep -oE  "[0-9.]+" /etc/issue | cut -d . -f 1`
	fi
	bit=`uname -m`
	if [[ ${bit} = "x86_64" ]]; then
		bit="x64"
	else
		bit="x32"
	fi
}
#菜单
start_menu(){
clear
echo && echo -e " TCP加速 一键安装管理脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
  -- 就是爱生活 | 94ish.me --
  
 ${Green_font_prefix}0.${Font_color_suffix} 升级脚本
————————————内核管理————————————
 ${Green_font_prefix}1.${Font_color_suffix} 安装 BBR/BBR魔改版内核
 ${Green_font_prefix}2.${Font_color_suffix} 安装 Lotserver(锐速)内核
————————————加速管理————————————
 ${Green_font_prefix}3.${Font_color_suffix} 使用BBR加速
 ${Green_font_prefix}4.${Font_color_suffix} 使用BBR魔改版加速
 ${Green_font_prefix}5.${Font_color_suffix} 使用暴力BBR魔改版加速(不支持部分系统)
 ${Green_font_prefix}6.${Font_color_suffix} 使用Lotserver(锐速)加速
————————————杂项管理————————————
 ${Green_font_prefix}7.${Font_color_suffix} 卸载全部加速
 ${Green_font_prefix}8.${Font_color_suffix} 系统配置优化
 ${Green_font_prefix}9.${Font_color_suffix} 退出脚本
————————————————————————————————" && echo

	check_status
	if [[ ${kernel_status} == "noinstall" ]]; then
		echo -e " 当前状态: ${Green_font_prefix}未安装${Font_color_suffix} 加速内核 ${Red_font_prefix}请先安装内核${Font_color_suffix}"
	else
		echo -e " 当前状态: ${Green_font_prefix}已安装${Font_color_suffix} ${_font_prefix}${kernel_status}${Font_color_suffix} 加速内核 , ${Green_font_prefix}${run_status}${Font_color_suffix}"
		
	fi
echo
read -p " 请输入数字 [0-9]:" num
case "$num" in
	0)
	Update_Shell
	;;
	1)
	check_sys_bbr
	;;
	2)
	check_sys_Lotsever
	;;
	3)
	startbbr
	;;
	4)
	startbbrmod
	;;
	5)
	startbbrmod_nanqinlang
	;;
	6)
	startlotserver
	;;
	7)
	remove_all
	;;
	8)
	optimizing_system
	;;
	9)
	exit 1
	;;
	*)
	clear
	echo -e "${Error}:请输入正确数字 [0-8]"
	sleep 5s
	start_menu
	;;
esac
}

#stty erase '^H' && read -p "请输入宝塔面板添加的网站域名,请不要修改添加之后的默认地址（例如:www.baidu.com，不带http/https）：" website
#echo -e "${green} 请确认您输入的网站域名：${none} $website"
#[[ -z $is_path ]] && is_path="n"

check_root
check_sys
check_version
[[ ${release} != "debian" ]] && [[ ${release} != "ubuntu" ]] && [[ ${release} != "centos" ]] && echo -e "${red} 本脚本不支持当前系统 ${release} !" && exit 1
start_menu
