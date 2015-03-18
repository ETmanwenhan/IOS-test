# IOS-test
Mac上Git的安装与简单使用

一、安装：

Git下载地址：
http://git-scm.com/downloads/
下载Git、配置Git：
http://blog.csdn.net/reactor1379/article/details/8008677


二、使用：
1、创建一个新的repository：IOS-test
可参考：http://blog.csdn.net/delphiwcdj/article/details/23055125

2、在Mac中新建一个本地仓库：local_repository并通过终端切换到该目录
$cd /Users/qianhua/Desktop/wen/local_repository  //切换目录

将github上的仓库clone到local_repository
$git clone https://github.com/ETmanwenhan/IOS-test.git
就会在local_repository中多了一个IOS-test的文件夹

3、手动往IOS-test中添加MapKit1项目并执行以下git命令
$git add .	//添加当前目录的所有文件到暂存区
可执行$git status  //查看状态

4、将暂存区中的变动提交到本地仓库
$git commit -m '这里写明提交的注释：提交到本地仓库'

5、将本地的仓库中所在变动的文件推送到远程仓库
$git push origin master  //clone 操作会自动使用默认的origin[remote-name]与master[branch-name]




需要熟记的git命令:
http://www.2cto.com/kf/201212/179768.html


《Pro Git》git圣经中文版：
http://download.csdn.net/download/lidaasky/7496835