include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=nf-deaf
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define KernelPackage/nf-deaf
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Netfilter Extensions
  TITLE:=Netfilter DEAF module
  FILES:=$(PKG_BUILD_DIR)/nf_deaf.ko
  AUTOLOAD:=$(call AutoLoad,99,nf-deaf)
  DEPENDS:=+kmod-nf-conntrack +kmod-nf-conntrack6
endef

define KernelPackage/nf-deaf/description
  This is a Netfilter module that implements DEAF functionality.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		M="$(PKG_BUILD_DIR)" \
		modules
endef

$(eval $(call KernelPackage,nf-deaf))
