package com.app.flutter_app

//import android.content.Context

import ai.protectt.app.security.common.helper.LogUtil
import ai.protectt.app.security.common.helper.Logger
import ai.protectt.app.security.common.helper.LoggingServiceUtil
import android.os.Bundle
//import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
//import android.os.Bundle

//import io.flutter.app.FlutterActivity
//import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class MainActivity: FlutterFragmentActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    getLoggingStatus()
  }

  override fun onResume() {
    super.onResume()
    LoggingServiceUtil.printLog(this, this);
    if(!checkAnalyticsEnabled()){
      LogUtil.writeLog("appresumed")
      GlobalScope.launch{
        delay(2000)
      }
      if (!checkAnalyticsEnabled()){                  //still not load
      // close app
       initAnalytics()                }         }     }


        override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
          GeneratedPluginRegistrant.registerWith(flutterEngine)
          MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "MyNativeChannel").setMethodCallHandler { call, result ->
            val param = call.arguments as Map<String, String>
            if (call.method == "getData") {
              result.success(PasswordEncoder.encode(param.get("input")));
            } else {
              result.notImplemented()
            }
          }

          MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "DownloadChannel").setMethodCallHandler{ call, result ->
            val param = call.arguments as Map<String,String>
            if (call.method == "download") {
              result.success(DownloadPDF.download(param.get("input"),applicationContext));
            } else {
              result.notImplemented()
            }

          }

        }
        // override fun onCreate(savedInstanceState: Bundle?) {
        //   super.onCreate(savedInstanceState)
        //   GeneratedPluginRegistrant.registerWith(this)


        //   MethodChannel(flutterView, "MyNativeChannel").setMethodCallHandler { call, result ->

        //     val param = call.arguments as Map<String, String>
        //     if (call.method == "getData") {
        //       print("call");
        //       result.success(PasswordEncoder.encode(param.get("input")));
        //     } else {
        //       result.notImplemented()
        //     }
        //   }
        //   MethodChannel(flutterView, "DownloadChannel").setMethodCallHandler { call, result ->

        //     val param = call.arguments as Map<String,String>
        //     if (call.method == "download") {
        //       print("calling download");
        //       result.success(DownloadPDF.download(param.get("input"),applicationContext));
        //     } else {
        //       result.notImplemented()
        //     }
        //   }

        // }

        fun logStatus() {

          log("")

        }

        fun log(str: String) {

          Logger.doLogging(this, this)

        }

        private external fun getLoggingStatus()


        external fun checkAnalyticsEnabled():Boolean       external fun initAnalytics()//



      }
