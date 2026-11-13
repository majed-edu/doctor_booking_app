import 'package:dio/dio.dart';
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
        ..options.receiveTimeout = timeOut;

        addDioHeaders();

      // إضافة الأدوات التي تراقب وتعرض تفاصيل الطلبات والاستجابات.
      addDioInterceptor();
      return dio!;
    } else {
      // إذا كانت النسخة موجودة، نعيد استخدامها مباشرة.
      return dio!;
    }
  }

   static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      // 'Authorization':
      //     'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsIm5hbWUiOiJEaWFhIiwiZW1haWwiOiJkaWFhQGV4YW1wbGUuY29tIiwicGhvbmUiOiIyMjIiLCJnZW5kZXIiOiIwIiwidHlwZSI6InVzZXIiLCJpYXQiOjE3OTQ1MzY3OTksImV4cCI6MTc5NzEyODc5OX0.0_E0YKIChgSHQ6i9kKmsK5-gY9qnY0xwI5CzInmC2ko',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
    };
  }

  // إضافة Interceptor لمراقبة تفاصيل طلبات الشبكة أثناء التطوير.
  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        // عرض جسم الطلب في سجل التشغيل.
        requestBody: true,
        // عرض ترويسات الطلب.
        requestHeader: true,
        // عرض ترويسات الاستجابة.
        responseHeader: true,
      ),
    );
  }
}
