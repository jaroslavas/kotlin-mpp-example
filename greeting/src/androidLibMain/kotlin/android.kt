package org.greeting

import android.os.Build
import kotlin.reflect.KClass

actual class Platform actual constructor() {
    actual val platform: String = "Android"
}

actual class Product(actual val user: String) {
    fun androidSpecificOperation() {
        println("I am ${Build.MODEL} by ${Build.MANUFACTURER}")
    }

    override fun toString() = "Android product of $user for ${Build.MODEL}"
}

actual object Factory {
    actual fun create(config: Map<String, String>) =
        Product(config["user"]!!)

    actual val platform: String = "android"
}

actual typealias Throws = kotlin.jvm.Throws