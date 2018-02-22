# 1. 介绍

`WangUI`开源项目致力于为开发提供WangUI ROM适配工具。

[![License](https://img.shields.io/badge/License-Apache%20V2.0-blue.svg)](LICENSE)

注意：因github上传文件为UNIX文件头，故根目录下的cmd需要转换成Windows文件头
    因签名需要用到java环境，未安装的请在ReleaseBuild.cmd中删除签名部分

# 2. 分支命名

开源项目的分支命名与手机型号、android版本和base系统版本对应,目前支持**所有基于flyme的**机型适配。

目录结构如下所示: 

    code_root  后期修改
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

后期修改

    > git clone https://github.com/WangCodes/WangUI_system_opensources.git -b all_testcode


# 4. 机型适配

<b>* 标准流程</b>

下载完代码以后, 将flyme刷机包解压至机型目录（devices/MEIZU/6753）

随后，在开源项目根目录, 执行以下命令开始适配过程

    > ReleaseBuild.cmd

注意，如果在适配时遇到选择文件或是文件夹（F或D）时，请输入“D”

稍等片刻，刷机包将生成于适配根目录（coderoot）
