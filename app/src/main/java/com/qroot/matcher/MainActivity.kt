package com.qroot.matcher

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.repeatable
import androidx.compose.animation.core.tween
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
import androidx.compose.ui.composed
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
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


                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column {
                            var left by remember { mutableStateOf("") }
                            var right by remember { mutableStateOf("") }

                            for (entry in wordPairs) {
                                WordRow(entry, {
                                    left = entry.first
                                    if (!left.isEmpty() && !right.isEmpty()) {
                                        val result = dictionary.contains(left, right)
                                        left = ""
                                        right = ""
                                        result
                                    } else {
                                        true
                                    }
                                }, {
                                    right = entry.second
                                    if (!left.isEmpty() && !right.isEmpty()) {
                                        val result = dictionary.contains(left, right)
                                        left = ""
                                        right = ""
                                        result
                                    } else {
                                        true
                                    }
                                })
                                RowSeparator()
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun WordRow(entry: Pair<String, String>, leftOnClick: () -> Boolean, rightOnClick: () -> Boolean) {
    Row(
        modifier = Modifier
            .wrapContentHeight()
            .height(60.dp)
    ) {
        WordCell(
            entry.first,
            Modifier
                .weight(1F)
                .fillMaxWidth(0.5f)
                .fillMaxHeight(),
            leftOnClick
        )
        // separator
        ColumnSeparator()
        WordCell(
            entry.second,
            Modifier
                .weight(1F)
                .background(Color.Blue)
                .fillMaxWidth(1f)
                .fillMaxHeight(),
            rightOnClick
        )
    }
}

@Composable
fun ColumnSeparator() {
    Column(modifier = Modifier.width(3.dp)) {}
}

@Composable
fun RowSeparator() {
    Row(modifier = Modifier.height(7.dp)) {}
}

@Composable
fun WordCell(name: String, modifier: Modifier, onClick: () -> Boolean = { true }) {
    val wordCellColor = Color.LightGray
    var okColor by remember { mutableStateOf(Color.Green) }
    var color by remember { mutableStateOf(wordCellColor) }
    var shake by remember { mutableStateOf(false) }
    val interactionSource = remember { MutableInteractionSource() }
        .also { interactionSource ->
            LaunchedEffect(interactionSource) {
                interactionSource.interactions.collect {
                    if (it is PressInteraction.Release) {
                        //color = wordCellColor
                    } else if (it is PressInteraction.Press) {
                        //color = Color.DarkGray
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
                .shake(shake, { shake = false })
                .clickable(
                    interactionSource = interactionSource,
                    indication = rememberRipple(
                        bounded = true,
                        radius = 250.dp,
                        color = okColor
                    ),
                    onClick = {
                        Log.d("BRR", "WordCell: BRRR")
                        shake = true
                        okColor = if (onClick()) Color.Green else Color.Red
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

fun Modifier.shake(enabled: Boolean, onAnimationFinish: () -> Unit) = composed(
    factory = {
        val distance by animateFloatAsState(
            targetValue = if (enabled) 15f else 0f,
            animationSpec = repeatable(
                iterations = 8,
                animation = tween(durationMillis = 50, easing = LinearEasing),
                repeatMode = RepeatMode.Reverse
            ),
            finishedListener = { onAnimationFinish.invoke() },
            label = ""
        )

        Modifier.graphicsLayer {
            translationX = if (enabled) distance else 0f
        }
    }
)

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    WordMatcherTheme {
        //WordCell("", "Android BIR")
        //WordCell("", "Android EKI")
    }
}