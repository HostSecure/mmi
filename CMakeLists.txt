cmake_minimum_required(VERSION 3.20)
project(MMI LANGUAGES CXX)

# Set C++ version
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Handle compilers automatically for Qt targets
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# Define path on macOS (for Mqtt)
if(MACOS)
    set (CMAKE_PREFIX_PATH "/usr/local/Cellar/qt/6.1.3")
endif()

# Find and import packages
find_package(Qt6 COMPONENTS Core REQUIRED)
find_package(Qt6 COMPONENTS Gui REQUIRED)
find_package(Qt6 COMPONENTS Qml REQUIRED)
find_package(Qt6 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS Mqtt REQUIRED)

include_directories("src")

set(HEADERS
    src/hostsecurecollection.h
    # Models
    src/edgemodel.h
    src/usbdevicemodel.h
    # Common
    src/commonutils.h
)

# Include source files
set(SOURCES
    src/hostsecurecollection.cpp
    # Models
    src/edgemodel.cpp
    src/usbdevicemodel.cpp
    # Common
    src/commonutils.cpp
)

# Resources
set(qml_resource_files
    "qml/main/qml.qrc"
    "qml/Common/Common.qrc"
    "qml/Images/Images.qrc"
    "qml/IconTheme/IconTheme.qrc"
)

add_executable(MMI main.cpp ${HEADERS} ${SOURCES} ${qml_resource_files})

# Hide qDebug messages in Release build
target_compile_definitions(MMI PUBLIC QT_DEBUG_NO_OUTPUT)

target_link_libraries(MMI PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Mqtt
    Qt6::Qml
    Qt6::Quick
    ${CMAKE_SOURCE_DIR}/connectivity/lib/libMessageHandlerStatic.a
)

target_include_directories(MMI PUBLIC "${CMAKE_SOURCE_DIR}/connectivity/include")
