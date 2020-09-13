#!/bin/bash
cd openwrt
rm -rf package/lean/luci-theme-argon  #删除源码自带的argon主题，因为最下面一个链接是增加了其他作者制作的argon主题
#
# Copyright (c) 2019-2020 shaingman <https://sharingman.cf>
#
# 说明：
# 除了第一行的#!/bin/bash不要动，其他的设置，前面带#表示不起作用，不带的表示起作用了（根据你自己需要打开或者关闭）
#
# 跟LEDE的不一样，19.07源码编译成功后就不需要登录密码的，所不需要设置密码为空
#

# 修改openwrt登陆地址,把下面的192.168.9.1修改成你想要的就可以了，其他的不要动
sed -i 's/192.168.1.1/192.168.9.1/g' package/base-files/files/bin/config_generate


#内核版本是会随着源码更新而改变的，在Lienol/openwrt的源码查看最好，以X86机型为例，源码的target/linux/x86文件夹可以看到有几个内核版本，x86文件夹里Makefile就可以查看源码正在使用什么内核
#修改版本内核（19.07默认使用4.14内核，还有4.19跟4.9的内核，自行选择。这个跟LEDE的有点不一样，这个是修改一行代码的）
#sed -i 's/KERNEL_PATCHVER:=4.14/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本


#添加自定义插件链接（自己想要什么就github里面搜索然后添加）
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge package/luci-theme-edge  #主题-edge-动态登陆界面
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom  #透明主题
git clone -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash  #openclash出国软件
git clone https://github.com/frainzy1477/luci-app-clash package/luci-app-clash  #clash出国软件
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan  #微信推送
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns  #smartdns DNS加速
git clone https://github.com/garypang13/luci-app-eqos package/luci-app-eqos  #内网IP限速工具


#lede的ShadowSocksR Plus+出国软件（19.07源码自带passwall出国软件）
git clone https://github.com/fw876/helloworld.git package/luci-app-ssr-plus
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/redsocks2
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/tcpping package/tcpping
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks package/microsocks


git clone https://github.com/jerrykuku/node-request.git package/node-request  #京东签到依赖
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus  #luci-app-jd-dailybonus[京东签到]


git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon  #argon-主题
#全新的[argon-主题]登录界面,图片背景跟随Bing.com，每天自动切换
#增加可自定义登录背景功能，请自行将文件上传到/www/luci-static/argon/background 目录下，支持jpg png gif格式图片，主题将会优先显示自定义背景，多个背景为随机显示，系统默认依然为从bing获取
#增加了可以强制锁定暗色模式的功能，如果需要，请登录ssh 输入：touch /etc/dark 即可开启，关闭请输入：rm -rf /etc/dark，关闭后颜色模式为跟随系统
