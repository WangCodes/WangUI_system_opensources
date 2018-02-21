# 1. 介绍

`WangUI`开源项目致力于为开发提供WangUI ROM适配工具。

[![License](https://img.shields.io/badge/License-Apache%20V2.0-blue.svg)](LICENSE)


# 2. 分支命名

开源项目的分支命名与手机型号、android版本和base系统版本对应,目前支持**基于flyme android版本5.x的魅蓝note2**机型适配，分支名称为meizu_m571_l_flyme。

目录结构如下所示: 

    code_root
     +-- 6753_build        魅蓝note2刷机适配资源
     +-- build             适配工具资源文件
     +-- build_official    WangUI基础资源文件
     +-- devices           机型文件
        +-- MEIZU          魅族机型文件
            +-- 6753       魅蓝note2适配文件及工作目录
     +-- npp               Notepad++程序
     +-- security          密钥文件
     +- README.md          本帮助文档
     +- ReleaseBuild.cmd   主工作程序
     +- Unpackdat.cmd      dat解包插件


# 3. 代码下载

通过git命令的-b参数, 选择需要下载的分支。
通过git clone命令同步远程代码: 

    > git clone https://github.com/WangCodes/WangUI_system_opensources.git -b meizu_m571_l_flyme


# 4. 机型适配

<b>* 标准流程</b>

下载完代码以后, 将flyme刷机包解压至机型目录（devices/MEIZU/6753）

随后，在开源项目根目录, 执行以下命令开始适配过程

    > ReleaseBuild.cmd

对于魅蓝note2机型，可以使用以下配置填入：

Your Project Name:6753

PCB company:MEIZU

随后，等待片刻，会弹出Notepad++编辑窗口，大家可以根据自己的需要编辑build.prop，随后保存，并关闭

注意，如果在适配时遇到选择文件或是文件夹（F或D）时，请输入“D”

稍等片刻，刷机包将生成于适配根目录（coderoot）
