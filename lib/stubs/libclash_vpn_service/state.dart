// Stub implementation for libclash_vpn_service state
// This is a temporary implementation to allow the project to build

enum FlutterVpnServiceState {
  disconnected,
  connecting,
  connected,
  reasserting,
  disconnecting,
}

class VpnServiceResultError {
  final String message;
  final int? code;
  
  VpnServiceResultError(this.message, {this.code});
  
  @override
  String toString() => 'VpnServiceResultError: $message (code: $code)';
}