第2章 项目架构

本章节主要讲解《高校社团交流平台——社团集结号》的项目架构，并阐述为什么这样做，这样做有什么好处，
如何落实到项目中等等一系列具有实际应用价值的技术。通过本章，读者可以整个项目的架构有更深入的了解。

第一节     基础知识
    因笔者主要从事java web 方面的工作，所以在技术选型上，选用了熟练的java语言，系统中用到了各式各样的实用主流框架，通过它们之间的
，通过他们的密切配合可以使我们的系统更加健壮，易于扩展，易于维护。本小节，重点介绍B/S结构，基于jsp + servlet + java bean
的web开发流程，以及基于MVC开源框架的web开发流程。

1.B/S结构
    B/S结构即浏览器/服务器结构，这种结构是web兴起后的一种网络结构模式，web浏览器是客户端最主要的应用软件。这种模式统一了客户端,
将系统功能实现的核心部分集中到服务器上，简化了系统的开发、维护和使用。客户机上只要安装一个浏览器，用于和用户进行交互，而
服务器大多采用类linux 系统，在服务器上，需要安装好必要的数据库软件如mysql，应用容器如tomcat,apache,ngnix等。当软件开发人员开发一个项目
时，需要将这个项目部署到服务器上的应用容器里，并启动应用容器。这时，应用容器就在时时监听着用户http请求。当用户在web浏览器访问项目对外公开的
接口时，就会返回给一个html，发送到web浏览器，web浏览器解析html,向用户展示。

2.基于jsp + servlet + java bean的开发流程
    jsp + servlet + java bean模式是java web 开发中最基础的一种开发模式，在这种模式下，servlet负责处理用户请求即当用户在web浏览器发送
一个请求后，在服务端最先由servlet接收到用户的http请求并做出相应的处理。jsp负责向用户进行展示，在java web 开发最早时只有servlet 处理用户
请求，而响应给用户的数据，全部是在servlet中输出的，这种方式下，程序逻辑与界面输出混在一起，不易开发和维护，由此诞生了jsp 技术，这时凡是向
用户进行展示的东西，可以在jsp中写，凡是控制程序逻辑的，可以在servlet 中写，由此带来的好处就是显示与控制的分离，前端工程师可以开发出html,
再由java web 工程师将html 转成jsp.从而大大提高工作效率。javabean负责封装数据和方法。jsp + servlet + java bean的开发流程能程序各个模块之间层次
清晰，显示与控制分离，。但是这种开发模式也带来了很多问题，比如一个servlet类，只能处理一个请求，对于一个大的系统来说
servlet的数量将会非常庞大，而造成不易维护和扩展的问题。面对企业级的web系统，这种模式显得力不从心。

3.基于MVC开源框架的开发流程
    jsp + servlet + java bean 模式的web开发流程其实就是MVC模型的雏形。MVC 即model view controller 也就是说让模型，视图和控制。在MVC模式
下，视图只负责展示数据给用户，控制则用于处理用户请求，而模型是控制层按照业务的逻辑对其进行CRUD操作,操作结果依然返回给控制层，而由控制层把数据
交给视图层去进行渲染。这种模式能够大大提高开发效率，使模块之间相对独立，方便复用。jsp + servlet + java bean模式恰恰符合了这种MVC模式，
由于jsp + servlet + java bean开发时的缺点不断突现，于是出现了第一个真正意义上的MVC框架apache软件基金会出的struts框架。
    struts框架首次提出，所有的用户请求都集中进行处理，由action映射文件决定请求对应的controller，返回的jsp文件。而在struts2中更加完善的
加入了值栈。这个值栈是在http session中一起存在的，当controller按照特定的业务逻辑对model进行处理后，可能需要显示一些数据给view,
这时controller可以将要在view中显示的数据放到值栈中，而在view(jsp)中，可以直接从值栈可读取到controller放到值栈的数据，并将数据处理成
html元素显示给用户。但是struts 框架也有它的缺点，比如每一个请求也都需要在配置文件中进行controller,view的配置，而view也不是特别灵活，
不能在controller里决定返回哪个view,只能在配置文件中配置,而且只有配置一个。再有struts 的controller 在每一个请求到来时，都会new 出一个新的
controller，而controller 只起到了控制的作用，不用每次都生成新的对象，由此会带来的问题就是系统内存占用大，影响系统稳定性。
    另一个MVC开源框架是spring mvc ,这个框架相比struts来说更加好用，spring mvc 中依然接收用户的所有请求，但是它没有配置文件，每个
请求也不需要在配置文件中配置了，需要做的，只是在controller类上加上spring mvc 提供的@Controller 注解，并在参数中指定这个控制器的
访问路径。而在controller类中，可以定义多个方法，使用注解，可以方便的指明url映射。而返回给用户的jsp，也可以任意指定，不再像struts那样必须事先
配置好。而且最关键一点，spring mvc 提供的controller 是单例的。当有多个请求访问一个controller时，只会有一个对象，自然内存占用少。
《高校社团交流平台——社团集结号》就选用了spring mvc做为其MVC控制。

第二节     项目如何构建
    对一个java web项目而言，构建可谓至关重要。构建项目是指将一个java web 项目进行编译，测试，生成一个可以在应用容器下运行的程序包等一系列
过程。一个java web项目有了构建的支持，那么它的打包，编译，发布，测试就会更加灵活，比如开发人员当开发完一部分代码后，只需要将代码提交到CVS版本
控制工具中，由测试人员更新到本地，直接执行构建脚本，就可以完成一系列工作，而不用单独建立一套开发环境。有个构建的支持，项目更容易做持续集成，有关
持续集成的介绍，将在后面的章节介绍。

1.对比ant, maven, gradle 三种开源构建工具
    目前主流的java web 项目构建工具有 ant,maven,gradle。三者都有一个项目构建文件存在于项目目录下。ant 叫build.xml,maven叫pom.xml
gradle 叫build.gradle文件。它们出现的先后顺序也是ant最早，gradle最晚，maven居中。 使用ant时，从编译文件开始，到最终项目包出现，都需要
在build.xml文件中定义一个个的target(目标) 通过各个目标之间的依赖，最终完成整个项目的构建。相比另外两个构建工具,ant的学习曲线也要高一些，
但它是优点就是特别灵活，对于一些结构复杂的项目，使用ant还是比较实用的。在eclipse开发环境下开发android项目时，默认就是使用ant对android项目
进行构建的，最终生成了.apk包。当然ant 在构建android项目生成apk包要比ant构建java web 项目生成的war包所需要的操作还要多。
    maven 相比ant来说，学习更加容易，用起来也更加方便了,技术也更加成熟。使用maven 与ant 最大的一个不同点就是你不需要再关心你的项目中用到的jar包在哪下载，
如何控制各个jar包的版本的问题了。在maven构建文件pom.xml中，可以定义很多的依赖。这里说的依赖，就是前边说的项目所依赖的jar包。maven 官网维护了一个
大的仓库，叫maven 中央仓库，在这个仓库中，基本包括了大部分java web 项目所依赖的开源jar包。我们需要做的，就是从maven官网查询依赖，
并在pom.xml 配置好这个依赖，当运行maven 目标时，这些依赖会被自动的下载到本地仓库(.m2仓库)。maven 自定义了几个目标，
例如clean,validate,compile,test,package,deploy 通过使用 maven默认提供的目标，我们就可以轻松的对java web 项目进行构建，生成部署所需要的
war包。另外maven提供了许多插件可以配置，比如jetty插件。jetty是一个内嵌式的servlet容器，所谓内嵌式，是指直接运行在内存中的，你不需要任何配置，
就可以把一个java web项目部署在上面。通过maven jetty插件，就可以直接把maven构建出的项目，部署到jetty容器上。
    gradle拥有了ant,和maven的全部优点，不但容易配置，而且使用灵活。gradle没有使用复杂的xml文件去描述一个依赖，而直接使用json格式来描述
一个依赖。既方便，又简单。对于maven仓库，gradle全部支持。在android studio中开发android项目，jetbrains 公司默认就提供gradle去构建android
项目，生成apk,而不是eclipse 那样，使用ant去构建。

3.采用maven构建《高校社团交流平台——社团集结号》分哪些步骤，有什么注意事项
    《高校社团交流平台——社团集结号》选用了成熟，稳定的maven做项目构建。在项目建立时，创建maven-quick-start 项目，并指定group id 和artifactId
group id 是你的项目前缀，例如cn.edu.hebtu.www,而artifactId是你的在此名字就可以。到这一步，maven项目就创建成功了。拉下来在maven仓库http://mvnrepository.com/中查询
到自己需要的依赖，在pom.xml配置好。最后配置一下maven 插件，比如maven jetty插件，maven compile 插件。这里需要特别注意一点，虽然maven提供了
compile目标，但是可能对自己的项目不实用，就需要配置其它的compile插件，比如，maven compile 插件对项目打包时默认是以操作系统的字符集对java文件
进行编译的，在windos下是GBK,在类linux下是UTF-8。那么，如果我们的项目最终运行在类linux系统下的，那么就需要配置maven compile插件，指定编译时的
字符集是UTF-8。

第三节     项目目录如何组织,web目录如何组织
1.项目目录如何组织
2.控制层，业务逻辑层，数据访问层深入理解
3.web目录如何组织


第四节     项目中用到的开源框架,类库
1.核心框架Spring
2.安全框架Shiro
3.ORM映射框架hibernate
4.MVC分层框架Spring mvc
5.定时任务框架Quartz
6.数据连接池类库C3P0,对比Druid
7.日志框架log4j
8.json数据格式处理类库gson
9.html解析类库jsoup
10.模拟网络操作类库httpclient
11.内嵌式servlet容器 jetty
12.装饰框架sitemesh
13.缓存框架ehcache
第五节     完整的一次请求流程
第六节     总结
第三章     前端技术
本章节主要讲解《高校社团交流平台——社团集结号》所采用的前端架构，在第二章中，我们着重讲了系统中‘后端’的架构，偏重于业务处理方面，
而这一章，我们将着重讲系统中‘前端’的架构，偏重于和用户进行交互方面。
第一节     传统的html + css + div + js 方式组织界面
第二节     基于BootStrap响应式布局方式组织界面
第三节     基于Flat-UI 去构建《高校社团交流平台——社团集结号》的交互界面
第四节     前端类库
1.jquery 类库
2.kindeditor 富文本编辑器类库
3.query validation 校验类库
4.AjaxFileUploader 上传文件类库
第五节     总结


