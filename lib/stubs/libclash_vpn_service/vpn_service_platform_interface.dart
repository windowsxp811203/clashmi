// Stub implementation for libclash_vpn_service vpn_service_platform_interface
// This is a temporary implementation to allow the project to build

import 'state.dart';

abstract class VpnServicePlatformInterface {
  static VpnServicePlatformInterface? _instance;
  
  static VpnServicePlatformInterface get instance {
    _instance ??= _DefaultVpnServicePlatform();
    return _instance!;
  }
  
  static set instance(VpnServicePlatformInterface instance) {
    _instance = instance;
  }
  
  Future<VpnServiceResultError?> startService() async {
    throw UnimplementedError('startService() has not been implemented.');
  }
  
  Future<VpnServiceResultError?> stopService() async {
    throw UnimplementedError('stopService() has not been implemented.');
  }
  
  Future<bool> isServiceConnected() async {
    throw UnimplementedError('isServiceConnected() has not been implemented.');
  }
}

class _DefaultVpnServicePlatform extends VpnServicePlatformInterface {
  @override
  Future<VpnServiceResultError?> startService() async {
    return null; // Stub implementation - success
  }
  
  @override
  Future<VpnServiceResultError?> stopService() async {
    return null; // Stub implementation - success
  }
  
  @override
  Future<bool> isServiceConnected() async {
    return false; // Stub implementation - not connected
  }
}