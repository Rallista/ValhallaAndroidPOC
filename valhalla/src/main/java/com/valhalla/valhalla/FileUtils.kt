package com.valhalla.valhalla

import android.content.Context
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.io.InputStream

public class FileUtils {
    companion object {
        fun copyAssetFileToStorage(context: Context, assetFileName: String): String {
            val assetManager = context.assets
            val outputFile = File(context.filesDir, assetFileName)

            try {
                val inputStream: InputStream = assetManager.open(assetFileName)
                val outputStream = FileOutputStream(outputFile)

                val bufferSize = 1024
                val buffer = ByteArray(bufferSize)
                var read: Int

                while (inputStream.read(buffer, 0, bufferSize).also { read = it } != -1) {
                    outputStream.write(buffer, 0, read)
                }

                inputStream.close()
                outputStream.close()

                return outputFile.absolutePath
            } catch (e: IOException) {
                e.printStackTrace()
                // Handle the exception as needed
            }

            return ""
        }
    }
}