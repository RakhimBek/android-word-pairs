package com.qroot.matcher

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.IntrinsicSize
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.qroot.matcher.ui.theme.WordMatcherTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            WordMatcherTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column {
                        val pairs = listOf(
                            Pair("bir", "one"),
                            Pair("eki", "two"),
                            Pair("ush", "two"),
                            Pair("tort", "three"),
                            Pair("bes", "three"),
                            Pair("alty", "three")
                        )
                        for (entry in pairs) {
                            Row(
                                modifier = Modifier
                                    .wrapContentHeight()
                                    .padding(top = 1.dp)
                                    .height(IntrinsicSize.Min)
                            ) {
                                WordCell(
                                    entry.first,
                                    Modifier
                                        .weight(1F)
                                        .fillMaxWidth(0.5f)
                                        .clickable { Log.d("zhmack", "onCreate: Yup!!") }
                                )
                                WordCell(
                                    entry.second,
                                    Modifier
                                        .weight(1F)
                                        .background(Color.Blue)
                                        .fillMaxWidth(1f)
                                        .clickable { Log.d("zhmack", "onCreate: Yop!") }
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun WordCell(name: String, modifier: Modifier = Modifier) {
    Column(
        Modifier.padding(start = 1.dp, end = 1.dp, top = 1.dp, bottom = 1.dp)
    ) {
        Text(
            text = "[$name]",
            modifier = modifier.background(Color.Yellow)
        )
    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    WordMatcherTheme {
        WordCell("Android BIR")
        WordCell("Android EKI")
    }
}