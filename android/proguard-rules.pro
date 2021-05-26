#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.embedding.engine.**  { *; }
-keep class io.flutter.embedding.plugins.**  { *; }
-keep class android.arch.lifecycle.**  { *; }
-keep class kotlin.internal.**  { *; }
-keep class com.jetrabbits.**  { *; }
-keep class androidx.**  { *; }
-dontwarn io.flutter.embedding.android.**
-dontwarn io.flutter.embedding.engine.**
-dontwarn android.arch.lifecycle.**

# local notifications plugin
#-keep class com.dexterous.** { *; }