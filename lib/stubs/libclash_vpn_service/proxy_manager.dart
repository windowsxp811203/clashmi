// Stub implementation for libclash_vpn_service proxy_manager
// This is a temporary implementation to allow the project to build

class ProxyManager {
  static ProxyManager? _instance;
  
  ProxyManager._internal();
  
  factory ProxyManager() {
    _instance ??= ProxyManager._internal();
    return _instance!;
  }
  
  void setExcludeDevices(Set<String> devices) {
    // Stub implementation
  }
  
  void clearExcludeDevices() {
    // Stub implementation
  }
}