package com.qroot.matcher

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.PressInteraction
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.material.ripple.rememberRipple
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
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
                    // state
                    val dictionary = WordPairsDictionary()
                    val wordPairs = dictionary.getAll()

                    Column {
                        for (entry in wordPairs) {
                            Row(
                                modifier = Modifier
                                    .wrapContentHeight()
                                    .height(50.dp)
                            ) {
                                WordCell(
                                    entry.first,
                                    Modifier
                                        .weight(1F)
                                        .fillMaxWidth(0.5f)
                                        .fillMaxHeight()
                                        .clickable { Log.d("zhmack", "onCreate: Yup!!") }
                                )
                                // separator
                                Column(modifier = Modifier.width(1.dp)) {}
                                WordCell(
                                    entry.second,
                                    Modifier
                                        .weight(1F)
                                        .background(Color.Blue)
                                        .fillMaxWidth(1f)
                                        .fillMaxHeight()
                                        .clickable { Log.d("zhmack", "onCreate: Yop!") }
                                )
                            }
                            Row(modifier = Modifier.height(1.dp)) {}
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun WordCell(name: String, modifier: Modifier) {
    val wordCellColor = Color.LightGray
    var color by remember { mutableStateOf(wordCellColor) }
    val interactionSource = remember { MutableInteractionSource() }
        .also { interactionSource ->
            LaunchedEffect(interactionSource) {
                interactionSource.interactions.collect {
                    if (it is PressInteraction.Release) {
                        //color = wordCellColor
                    } else if (it is PressInteraction.Press) {
                        color = Color.DarkGray
                    } else if (it is PressInteraction.Cancel) {
                        //color = wordCellColor
                    }
                }
            }
        }
    Column(
        modifier = modifier
    ) {
        Row(
            modifier = Modifier
                .fillMaxHeight()
                .fillMaxWidth()
                .background(color)
                .clickable(
                    interactionSource = interactionSource,
                    indication = rememberRipple(
                        bounded = true,
                        radius = 250.dp,
                        color = Color.Yellow
                    ),
                    onClick = {
                        Log.d("BRR", "WordCell: BRRR")
                    }
                ),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.Center,
        ) {
            Text(
                text = "[$name]",
                modifier = Modifier
                    .wrapContentHeight()
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    WordMatcherTheme {
        //WordCell("", "Android BIR")
        //WordCell("", "Android EKI")
    }
}