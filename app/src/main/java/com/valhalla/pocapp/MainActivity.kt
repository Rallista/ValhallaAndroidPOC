package com.valhalla.pocapp

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.valhalla.pocapp.ui.theme.ValhallaAndroidPOCTheme
import com.valhalla.valhalla.ValhallaKotlin

class MainActivity : ComponentActivity() {

    private val valhalla = ValhallaKotlin()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            ValhallaAndroidPOCTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Greeting("Valhalla")

                    Button(onClick = {
                        val request = ""
                        val route = valhalla.route(request, "test")

                        Log.d("MainActivity", "route: $route")
                    }) {
                        Text("Make Route")
                    }
                }
            }
        }
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