# 子文件的名称
SUB_DIR_NAME := base

CSRCS += $(wildcard $(MK_DEMO_DIR)/$(SUB_DIR_NAME)/*.c)
CXXSRCS += $(wildcard $(MK_DEMO_DIR)/$(SUB_DIR_NAME)/*.cpp)

# 用于makefile搜索文件
VPATH += :$(MK_DEMO_DIR)/$(SUB_DIR_NAME)

INCLUDE += -I$(MK_DEMO_DIR)/$(SUB_DIR_NAME)
