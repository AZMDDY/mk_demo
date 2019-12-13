# makefile 模板

> 这是一个makefile的模板，目的是快速的构建项目。

## 功能

+ 支持多目录：在子目录中添加一个`*.mk`文件，文件内容参照实例`./base/base.mk`。然后在根目录的makefile文件中包含它。`include $(MK_DEMO_DIR)/base/base.mk`
+ 支持将项目编译成可执行文件、动态库和静态库。根目录下的makefile文件中提供了可选项。
+ 支持C/C++混合编译。
+ 支持链接第三方库。
+ 生成的可执行文件以及库文件都在`out/**`目录下。

## 移植

如何将该`makefile`移植到自己的项目上？

1. 将`makefile`以及`*.mk`中`MK_DEMO_DIR`替换成与自己项目相关的。例如：你的项目名为`test`，那么，全局替换`MK_DMEO_DIR`->`TEST_DIR`。当然这个名称随你所爱。
2. 更改编译生成文件的名称。给根目录下的`PROJECT_NAME`变量赋予你想要的名称。如果编译成库，库的后缀不需要添加。
3. 指定编译类型。给根目录下的`PROJECT_TYPE`变量赋予可选的三个值(`PROJECT_EXE`: 可执行文件， `PROJECT_STATIC_LIB`:静态库，`PROJECT_SHARED_LIB`: 动态库)。
4. 如果项目中需要链接第三方库，则将第三方库的头文件路径、库文件路径以及所使用的库，添加到根目录的`makefile`中的相应变量中。

## 注意事项

1. 编译成库时，最好不用
`CSRCS += $(wildcard $(MK_DEMO_DIR)/*.c) CXXSRCS += $(wildcard $(MK_DEMO_DIR)/*.cpp)`去搜索项目根目录下的源文件，会把main.c/main.cpp包含进去，可以一个一个的将根目录下的源文件添加进去。

