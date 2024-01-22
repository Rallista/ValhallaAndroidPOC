package com.valhalla.valhalla

public class ValhallaKotlin {
    companion object {
        init {
            System.loadLibrary("valhalla_wrapper")
        }
    }

    external fun route(request: String, configPath: String): String
}