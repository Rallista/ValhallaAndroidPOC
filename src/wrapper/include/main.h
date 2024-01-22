#ifndef JNI_WRAPPER_H
#define JNI_WRAPPER_H

#include <jni.h>
#include "valhalla_actor.h"

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT jstring JNICALL Java_com_valhalla_valhalla_ValhallaKotlin_route(JNIEnv *env,
                                                jobject thiz,
                                                jstring jRequest,
                                                jstring jConfigPath);

#ifdef __cplusplus
}
#endif

#endif // JNI_WRAPPER_H