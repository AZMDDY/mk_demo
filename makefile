# mk_demo项目的根目录
MK_DEMO_DIR := $(shell pwd)

# 项目编译类型：可执行文件，静态库，动态库
PROJECT_EXE := EXE
PROJECT_STATIC_LIB := STATIC_LIB
PROJECT_SHARED_LIB := SHARED_LIB
# 默认项目编译成可执行文件
PROJECT_TYPE := $(PROJECT_EXE)

# 可执行文件/库文件的名称(不带后缀名)
PROJECT_NAME := mk_demo

# C/C++编译器
CC 	:= gcc
CXX	:= g++

# 编译选项
CFLAGS 	 ?= -Wall -O3 -g0
CXXFLAGS ?= -Wall -O3 -g0

ifeq ($(PROJECT_TYPE), $(PROJECT_SHARED_LIB))
	CFLAGS   += -fPIC
	CXXFLAGS += -fPIC
	PROJECT_NAME := lib$(PROJECT_NAME).so
	PROJECT_NAME := $(MK_DEMO_DIR)/out/lib/$(PROJECT_NAME)
else ifeq ($(PROJECT_TYPE), $(PROJECT_STATIC_LIB))
	PROJECT_NAME := lib$(PROJECT_NAME).a
	PROJECT_NAME := $(MK_DEMO_DIR)/out/lib/$(PROJECT_NAME)
else
	PROJECT_NAME := $(MK_DEMO_DIR)/out/bin/$(PROJECT_NAME)
endif

# 头文件路径
INCLUDE += -I$(MK_DEMO_DIR)/

# 库文件路径
LDFLAGS	+= -L$(MK_DEMO_DIR)/

# 所使用的库
LIBS	:= -lpthread

# 包含子目录下的makefile文件
include $(MK_DEMO_DIR)/base/base.mk

# 项目根目录下的源文件
CSRCS += $(wildcard $(MK_DEMO_DIR)/*.c)
CXXSRCS += $(wildcard $(MK_DEMO_DIR)/*.cpp)
SRCS = $(CSRCS) $(CXXSRCS)

OBJEXT ?= .o 
COBJS := $(CSRCS:.c=$(OBJEXT))
CXXOBJS := $(CXXSRCS:.cpp=$(OBJEXT))
OBJS := $(COBJS) $(CXXOBJS)

# 编译规则

all:$(PROJECT_NAME)

%.o:%.c 
	@$(CC) $(CFLAGS) -c $< -o $@ $(LDFLAGS) $(INCLUDE) $(LIBS)
	@echo "CC $<"
	
%.o:%.cpp
	@$(CXX) $(CXXFLAGS) -c $< -o $@ $(LDFLAGS) $(INCLUDE) $(LIBS)
	@echo "CXX $<"


ifeq ($(PROJECT_TYPE), $(PROJECT_SHARED_LIB))
$(PROJECT_NAME):$(OBJS)
	$(shell if [ -f $(MK_DEMO_DIR)/out/lib ]; then echo "out folders exist"; else mkdir -p '$(MK_DEMO_DIR)/out/lib'; fi;)
	$(CXX) -shared -fPIC -o $(PROJECT_NAME) $(OBJS) $(LIBS)
else ifeq ($(PROJECT_TYPE), $(PROJECT_STATIC_LIB))
$(PROJECT_NAME):$(OBJS)
	$(shell if [ -f $(MK_DEMO_DIR)/out/lib ]; then echo "out folders exist"; else mkdir -p '$(MK_DEMO_DIR)/out/lib'; fi;)
	ar cr $@ $^	$(LIBS)
else
$(PROJECT_NAME):$(OBJS)
	$(shell if [ -f $(MK_DEMO_DIR)/out/bin ]; then echo "out folders exist"; else mkdir -p '$(MK_DEMO_DIR)/out/bin'; fi;)
	$(CXX) -o $(PROJECT_NAME) $(OBJS) $(LIBS)
endif

.PHONY : clean
clean:
	rm -rf $(OBJS) $(PROJECT_NAME)








