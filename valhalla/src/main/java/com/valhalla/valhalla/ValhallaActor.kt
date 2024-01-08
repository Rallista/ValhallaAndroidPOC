package com.valhalla.valhalla

public class ValhallaActor {
    companion object {
        init {
            System.loadLibrary("valhalla")
        }
    }

    external fun route(request: String, configPath: String): String
}