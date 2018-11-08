package org.greeting


import kotlinx.coroutines.*
import kotlin.coroutines.CoroutineContext

expect class Platform() {
    val platform: String
}

class Greeting {
    fun greeting(): String = "Hello, ${Platform().platform}"


    suspend fun anotherGreeting(): String {
        return runBlocking {
            delay(1500)
            Platform().platform
        }
    }


    fun anotherGreetingAsync(context: CoroutineContext): Deferred<String> {
        return GlobalScope.async(context) {
            anotherGreeting()
        }
    }

}


class DummyClass {
    // Needed for native compiler to include CoroutineDispatcher interface in final framework
    public val dummyDispatcher: CoroutineDispatcher? = null
}