// ignore_for_file: empty_catches, unused_catch_stack

import 'dart:io';

import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/modules/clash_setting_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

/// Zashboard Integration
/// 
/// This class provides integration with the Zashboard dashboard using Clash API.
/// Zashboard is a web-based dashboard that provides a user interface for managing
/// Clash/Mihomo proxy configurations.
/// 
/// Features:
/// - Serves Zashboard static files from assets
/// - Automatically configures connection to Clash API
/// - Provides proper URL with authentication
class Zashboard {
  static HttpServer? _server;
  
  /// Get the dashboard URL with proper authentication
  static Future<String> getUrl() async {
    String secret = await ClashHttpApi.getSecret();
    return 'http://127.0.0.1:${SettingManager.getConfig().boardLocalPort}?hostname=127.0.0.1&port=${ClashSettingManager.getControlPort()}&secret=$secret&http=true';
  }

  /// Start the Zashboard local server
  static Future<ReturnResult<String>> start() async {
    if (_server == null) {
      try {
        _server = await HttpServer.bind(
            "127.0.0.1", SettingManager.getConfig().boardLocalPort);
        Log.i("Zashboard server started on port ${SettingManager.getConfig().boardLocalPort}");
      } catch (err, stacktrace) {
        Log.e("Failed to start Zashboard server: $err");
        return ReturnResult(error: ReturnResultError(err.toString()));
      }

      _server!.listen((req) async {
        try {
          if (req.method == "GET") {
            String path = req.requestedUri.path.replaceFirst('/', '');
            if (path.isEmpty) {
              path = 'index.html';
            }
            final name = basename(path);
            final mime = lookupMimeType(name) ?? 'text/plain';
            
            try {
              final data = await rootBundle.load("assets/zashboard/$path");
              req.response.headers.add('Content-Type', '$mime; charset=utf-8');
              req.response.add(data.buffer.asUint8List());
              req.response.close();
              Log.d("Served Zashboard file: $path");
            } catch (assetError) {
              Log.w("Zashboard asset not found: $path");
              req.response.statusCode = HttpStatus.notFound;
              req.response.write("Asset not found: $path");
              req.response.close();
            }
          } else {
            req.response.statusCode = HttpStatus.methodNotAllowed;
            req.response.close();
          }
        } catch (err, stacktrace) {
          Log.e("Error serving Zashboard request: $err");
          req.response.statusCode = HttpStatus.internalServerError;
          req.response.close();
        }
      });
    }

    return ReturnResult(data: await getUrl());
  }

  /// Stop the Zashboard local server
  static Future<void> stop() async {
    if (_server != null) {
      await _server!.close();
      _server = null;
      Log.i("Zashboard server stopped");
    }
  }
}
