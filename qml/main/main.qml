import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Common
import HostSecure

ApplicationWindow {
   id: window
   width: 640
   height: 520
   minimumWidth: 600
   minimumHeight: 500
   visible: true
   title: qsTr("Host Secure")

   header: TopBar {
      Material.elevation: 1
      Material.background: Colors.topBarBackgroundColor
   }

   MainView {
      anchors.fill: parent
   }

   background: Image {
      id: name
      source: "qrc:/Images/gradient.jpg"

      Rectangle {
         anchors.fill: parent
         color: "black"
         opacity: 0.5
      }
   }
}
