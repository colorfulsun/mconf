# PHONY += menuconfig

# SRCARCH := ..

# ifdef KBUILD_KCONFIG
# Kconfig := $(KBUILD_KCONFIG)
# else
# Kconfig := Kconfig
# endif

# ifeq ($(quiet),silent_)
# silent := -s
# endif

# # We need this, in case the user has it in its environment
# unexport CONFIG_

# menuconfig: mconf
# 	$< $(silent) $(Kconfig)


# conf-objs	:= conf.o  zconf.tab.o

# hostprogs-y := conf

# targets		+= zconf.lex.c

# # generated files seem to need this to find local include files
# HOSTCFLAGS_zconf.lex.o	:= -I$(src)
# HOSTCFLAGS_zconf.tab.o	:= -I$(src)

# # mconf: Used for the menuconfig target based on lxdialog
# hostprogs-y	+= mconf
# lxdialog	:= checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
# mconf-objs	:= mconf.o zconf.tab.o $(addprefix lxdialog/, $(lxdialog))

# HOSTLDLIBS_mconf = $(shell . mconf-cfg && echo $$libs)
# $(foreach f, mconf.o $(lxdialog), \
#   $(eval HOSTCFLAGS_$f = $$(shell . mconf-cfg && echo $$$$cflags)))

# mconf.o: mconf-cfg
# $(addprefix lxdialog/, $(lxdialog)): mconf-cfg

# clean-files += .*conf-cfg

# Makefile  
  
# 定义变量以包含 lxdialog 目录下的所有 .c 文件  
LXDIALOG_SOURCES := $(wildcard lxdialog/*.c)  
LXDIALOG_OBJECTS := $(LXDIALOG_SOURCES:.c=.o)  # 推导对应的 .o 文件名  
  
# 最终的可执行文件  
TARGET := myprogram  
  
# 定义依赖和规则  
all: lxdialog $(TARGET)  
  
$(TARGET): mconf.o zconf.tab.o $(LXDIALOG_OBJECTS)  
	gcc $^ -l curses -o $@  
  
# 编译 .c 文件为 .o 文件  
%.o: %.c  
	gcc -c $< -o $@  
  
# 伪目标，用于编译 lxdialog 目录下的所有 .c 文件  
.PHONY: lxdialog  
lxdialog: $(LXDIALOG_OBJECTS)  
	@echo "Compiled lxdialog objects:" $(LXDIALOG_OBJECTS)  
  
# 清理编译生成的文件  
.PHONY: clean  
clean:  
	rm -f *.o $(TARGET) $(LXDIALOG_OBJECTS)  
  
# 注意：这里没有包含 Kconfig 或 KBUILD_KCONFIG 的处理，  
# 因为这些通常与内核构建系统相关，而您的项目似乎是一个独立的程序。  
# 如果您确实需要处理 Kconfig 文件，那么您可能需要一个不同的脚本来解析它，  
# 或者将您的项目集成到一个更大的内核构建环境中。