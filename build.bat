@echo off

:: 1. 创建输出目录
if not exist "bin" mkdir bin

:: 2. 编译 Java 源码 (Java 1.8)
echo Compiling Java sources...
javac -Xlint:deprecation -d bin -sourcepath src -classpath bin src\Graphwar\*.java src\GraphServer\*.java src\GlobalServer\*.java src\RoomServer\*.java
if %errorlevel% neq 0 (
    echo Compilation failed!
    exit /b 1
)

:: 3. 复制编译后的 class 文件到根目录，用于打包
echo Copying class files...
xcopy /E /I /Y "bin\Graphwar" "Graphwar" >nul
xcopy /E /I /Y "bin\GraphServer" "GraphServer" >nul
xcopy /E /I /Y "bin\GlobalServer" "GlobalServer" >nul
xcopy /E /I /Y "bin\RoomServer" "RoomServer" >nul

:: 4. 打包生成 JAR 文件
echo Packaging JARs...
jar cfe graphwar.jar Graphwar.Graphwar GraphServer Graphwar rsc
jar cfe roomServer.jar RoomServer.RoomServer GraphServer RoomServer rsc
jar cfe globalServer.jar GlobalServer.GlobalServer GraphServer GlobalServer rsc

:: 5. 清理临时复制的目录
echo Cleaning up...
rmdir /S /Q Graphwar
rmdir /S /Q GraphServer
rmdir /S /Q GlobalServer
rmdir /S /Q RoomServer

echo Build completed successfully!
