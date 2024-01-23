package com.valhalla.pocapp

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.valhalla.pocapp.ui.theme.ValhallaAndroidPOCTheme
import com.valhalla.valhalla.FileUtils
import com.valhalla.valhalla.ValhallaKotlin

class MainActivity : ComponentActivity() {

    private val valhalla = ValhallaKotlin()


    private var response by mutableStateOf("")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val configPath = setupFiles()

        setContent {
            ValhallaAndroidPOCTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column {
                        Greeting("Valhalla")

                        Button(onClick = {
                            val request =
                                "{\"locations\":[{\"lat\":45.9007652,\"lon\":-123.1504026},{\"lat\":45.83842,\"lon\":-123.3891069}],\"costing\":\"auto\",\"units\":\"miles\"}\n"

                            val route = valhalla.route(request, configPath)

                            Log.d("MainActivity", "valhalla out json: $route")
                            response = route
                        }) {
                            Text("Make Route")
                        }

                        Text(text = response)

                        Spacer(modifier = Modifier.weight(1f))
                    }
                }
            }
        }
    }

    private fun setupFiles(): String {
        val configPath = FileUtils.copyAssetFileToStorage(this, "valhalla.json");
        val tarPath = FileUtils.copyAssetFileToStorage(this, "sample.tar")
        val adminsPath = FileUtils.copyAssetFileToStorage(this, "admins.sqlite")
        Log.d("MainActivity", "configPath: $configPath, tarPath: $tarPath, adminsPath: $adminsPath")
        return configPath
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    ValhallaAndroidPOCTheme {
        Greeting("Android")
    }
}