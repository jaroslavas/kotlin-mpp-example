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
            throw Exception("Test exception");
            Platform().platform
        }
    }


    fun anotherGreetingAsync(context: CoroutineContext): Deferred<String> {
        return GlobalScope.async(context) {
            anotherGreeting()
        }
    }

}

@Throws
fun <T: Any> Deferred<T>.getCompletedOrThrow(): T = this.getCompleted()



class DummyClass {
    // Needed for native compiler to include CoroutineDispatcher interface in final framework
    public val dummyDispatcher: CoroutineDispatcher? = null
}

@Target(AnnotationTarget.FUNCTION, AnnotationTarget.CONSTRUCTOR)
expect annotation class Throws(vararg val exceptionClasses: kotlin.reflect.KClass<out kotlin.Throwable>)