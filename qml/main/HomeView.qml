import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Common


Pane {
   padding: 10
   background: null

   ListView {
      id: edgeListView
      model: HSC.edgeModel
      anchors.fill: parent
      clip: true
      spacing: 10
      ScrollBar.vertical: ScrollBar { id: scrollBar }
      delegate: TransparentPane {
         width: ListView.view.width - scrollBar.width
         radius: 5

         Item {
            id: rootItem
            width: parent.width
            implicitHeight: mainColumn.implicitHeight

            TransparentPane {
               rotation: -20
               anchors.centerIn: parent
               Material.elevation: 10
               visible: !model.isOnline
               z: 2

               Label {
                  text: "OFFLINE"
                  font.pixelSize: 25
                  font.bold: true
               }
            }

            ColumnLayout {
               id: mainColumn
               enabled: model.isOnline
               spacing: 10
               anchors.left: parent.left
               anchors.right: parent.right

               RowLayout {
                  Icon {
                     icon.name: "computer"
                     icon.color: mainColumn.enabled ? Material.foreground : Material.hintTextColor
                     icon.height: 30
                     icon.width: 30
                  }
                  Label {
                     text: model.id
                     font.pixelSize: 18
                     font.bold: true
                  }
               }

               Flickable {
                  Layout.fillWidth: true
                  Layout.preferredHeight: contentItem.childrenRect.height + scrollBarDevices.height
                  contentHeight: contentItem.childrenRect.height
                  contentWidth: contentItem.childrenRect.width
                  clip: true
                  flickableDirection: Flickable.HorizontalFlick
                  ScrollBar.horizontal: ScrollBar { id: scrollBarDevices }

                  RowLayout {
                     Repeater {
                        model: deviceModel
                        delegate: TransparentPane {
                           ColumnLayout {
                              Label {
                                 text: "Name of device"
                                 font.pixelSize: 16
                                 font.bold: true
                              }

                              Repeater {
                                 model: [
                                    { title: "Last heartbeat", value: lastHeartBeat },
                                    { title: "Device ID",      value: deviceId },
                                    { title: "Device serial",  value: deviceSerial },
                                 ]
                                 delegate: RowLayout {
                                    Label { text: modelData.title; enabled: false; Layout.preferredWidth: 100 }
                                    Label { text: modelData.value; }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }

   TransparentPane {
      visible: edgeListView.count === 0
      anchors.centerIn: parent
      radius: 5

      Label {
         anchors.centerIn: parent
         text: "No edges connected.."
         enabled: false
         font.bold: true
         font.pixelSize: 25
      }
   }
}
