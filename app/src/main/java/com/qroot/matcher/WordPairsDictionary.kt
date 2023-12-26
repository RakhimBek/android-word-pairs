package com.qroot.matcher

import android.app.Application

class WordPairsDictionary : Application() {
    private val dictionary = listOf(
        Pair("bir", "eins"),
        Pair("eki", "zwei"),
        Pair("ush", "drei"),
        Pair("tort", "vier"),
        Pair("bes", "funf"),
        Pair("alty", "sechs"),
        Pair("jeti", "sieben"),
        Pair("segiz", "acht"),
        Pair("togiz", "neun"),
        Pair("on", "zehn")
    )

    fun getAll(): List<Pair<String, String>> {
        return dictionary
    }
}