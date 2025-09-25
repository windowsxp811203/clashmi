// Stub implementation for libclash_vpn_service vpn_service
// This is a temporary implementation to allow the project to build

import 'dart:async';
import 'state.dart';

class FlutterVpnServiceConfig {
  String? core_path;
  String? core_path_patch;
  String? core_path_patch_final;
  String? log_path;
  String? err_path;
  String? id;
  String? version;
  String? name;
  String? secret;
  bool? prepare;
  bool? wake_lock;
  
  FlutterVpnServiceConfig();
}

class FlutterVpnService {
  static Future<String> getSystemVersion() async {
    return "1.0.0"; // Stub version
  }
  
  static Future<void> setExcludeFromRecents(bool exclude) async {
    // Stub implementation
  }
  
  static Future<VpnServiceResultError?> installService() async {
    // Stub implementation - return success
    return null;
  }
  
  static Future<VpnServiceResultError?> uninstallService() async {
    // Stub implementation - return success
    return null;
  }
  
  static Future<VpnServiceResultError?> start() async {
    // Stub implementation - return success
    return null;
  }
  
  static Future<VpnServiceResultError?> stop() async {
    // Stub implementation - return success
    return null;
  }
  
  static Future<bool> isConnected() async {
    return false; // Stub - always disconnected
  }
  
  static Future<bool> isInstalled() async {
    return false; // Stub - not installed
  }
  
  static void prepareConfig({
    required FlutterVpnServiceConfig config,
    required String bundleIdentifier,
    required String uiServerAddress,
    required String uiLocalizedDescription,
  }) {
    // Stub implementation
  }
  
  static void setOnEventListener(Function(FlutterVpnServiceState state, Map<String, String> params) listener) {
    // Stub implementation
  }
}