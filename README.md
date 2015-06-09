#项目简介
社团集结号(clubassembly)是模仿人人网-社团人的一个java web 项目。旨在做出java实用框架整合的示例性项目。

#项目WiKi
[项目WiKi](https://git.oschina.net/hbsdtaoxue/clubassembly/wikis/Home)

#前端技术
jquery, flat-ui, bootstrap, jquery-validation, ajax, matrix 等

#后端技术
spring, spring mvc, hibernate, maven, [shiro](https://git.oschina.net/hbsdtaoxue/clubassembly/wikis/Home), sitemesh ,quartz等

#项目展示
项目前台主页：http://ztao.xyz:8080/clubassembly/index
项目后台主页：http://ztao.xyz:8080/clubassembly/manager/login

#示例账号
项目前台:641041018@qq.com,admin
项目后台:641041018@qq.com,admin

#运行方法

1.执行sql脚本，位于src\main\resources\sql\mysql\clubassembly_bak002.sql

2.执行maven构建命令，进行web项目构建

3.maven构建完成之后，将target/clubassembly.war放到tomcat容器下。

4.在tomcat 目录下建立clubassemblyResourdces 文件夹

5.在tomcat/conf/server.xml 文件中的</Host> 的上方加入 <Context reloadable="true" docBase="../clubassemblyResources" debug="0" path="/clubassembly/clubassemblyResources"/>

6.运行tomcat即可。















