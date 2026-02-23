import QtQuick
import Quickshell
import "."

Window {
    id: calendarRoot
    visible: false
    
    // Simple positioning: 10 pixels from the left, 50 from the top
    x: 10
    y: 50
    width: 250
    height: 300

    Rectangle {
        anchors.fill: parent
        color: Colors.bg0 
        border.color: Colors.bg2
        border.width: 1
        radius: 12

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Text {
                text: Qt.formatDateTime(new Date(), "MMMM yyyy")
                color: Colors.green
                font.pixelSize: 18
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Grid {
                columns: 7
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    model: 31
                    Rectangle {
                        width: 25; height: 25; radius: 4
                        color: (index + 1 === new Date().getDate()) ? Colors.green : "transparent"
                        Text {
                            anchors.centerIn: parent
                            text: index + 1
                            color: (index + 1 === new Date().getDate()) ? Colors.bg0 : Colors.fg
                        }
                    }
                }
            }
        }
    }
}