#include <jni.h>
#include <android/log.h>
#include <valhalla-actor.h>

using namespace valhalla;

extern "C" {
    JNIEXPORT jstring JNICALL Java_com_example_valhalla_ValhallaActor_route(
            JNIEnv* env,
            jobject obj,
            jstring request,
            jstring config_path
    ) {
        const char* requestStr = env->GetStringUTFChars(request, nullptr);
        const char* configPathStr = env->GetStringUTFChars(config_path, nullptr);

        try {
            actor = new ValhallaActor();
            return actor->route(requestStr, configPathStr);
        } catch (const valhalla::valhalla_exception_t &err) {
            __android_log_print(ANDROID_LOG_ERROR, "ValhallaActor", "actor route valhalla_exception: %s", err.what());
            std::string c_code = std::to_string(err.code);

            jstring code = env->NewStringUTF(c_code.c_str());
            jstring message = env->NewStringUTF(err.message.c_str());

            // Return the rich JSON error.
            jstring errorStr = env->NewStringUTF((std::string("{\"code\":") + c_code + ",\"message\":\"" + err.message + "\"}").c_str());

            env->ReleaseStringUTFChars(request, requestStr);
            env->ReleaseStringUTFChars(config_path, configPathStr);

            return errorStr;
        } catch (...) {
            __android_log_print(ANDROID_LOG_ERROR, "ValhallaActor", "actor route unknown exception");
            jstring str = env->NewStringUTF("");
            return str;
        }
    }
} // extern "C"