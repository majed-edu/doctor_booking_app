import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:doctor_booking_app/core/helpers/constants.dart';
import 'package:doctor_booking_app/core/helpers/shared_pref_helper.dart';
/*
  شرح الملف ببساطة:
  هذا الملف مسؤول عن إنشاء نسخة واحدة (Singleton) من Dio，
  وإعدادها لإرسال واستقبال طلبات HTTP داخل التطبيق.

  استخدام نسخة واحدة من Dio يساعد على إعادة استخدام نفس الإعدادات
  والـ interceptors في جميع أجزاء التطبيق.
*/

class DioFactory {
  // Constructor خاص لمنع إنشاء كائنات من هذا الكلاس مباشرة.
  // يتم استخدام الدوال static بدلًا من إنشاء instance.
  DioFactory._();

  // نخزن نسخة Dio هنا حتى نعيد استخدامها بدل إنشاء نسخة جديدة كل مرة.
  static Dio? dio;
  static VoidCallback? _onUnauthorized;
  static bool _unauthorizedHandled = false;

  static void setUnauthorizedHandler(VoidCallback handler) {
    _onUnauthorized = handler;
  }

  // إرجاع نسخة Dio الجاهزة للاستخدام.
  static Dio getDio() {
    // المدة القصوى للاتصال واستقبال الاستجابة من الخادم.
    Duration timeOut = const Duration(seconds: 30);

    // إنشاء Dio مرة واحدة فقط إذا لم تكن قد أُنشئت من قبل.
    if (dio == null) {
      dio = Dio();

      // تطبيق إعدادات المهلة على طلبات Dio.
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.headers = {'Accept': 'application/json'};

      // إضافة الأدوات التي تراقب وتعرض تفاصيل الطلبات والاستجابات.
      addDioInterceptor();
      return dio!;
    } else {
      // إذا كانت النسخة موجودة، نعيد استخدامها مباشرة.
      return dio!;
    }
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
    _unauthorizedHandled = false;
  }

  static Future<void> clearToken() async {
    await SharedPrefHelper.removeData(SharedPrefKeys.userToken);
    dio?.options.headers.remove('Authorization');
    isLoggedInUser = false;
  }

  // إضافة Interceptor لمراقبة تفاصيل طلبات الشبكة أثناء التطوير.
  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.userToken,
          );
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          } else {
            options.headers.remove('Authorization');
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && !_unauthorizedHandled) {
            _unauthorizedHandled = true;
            await clearToken();
            _onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
