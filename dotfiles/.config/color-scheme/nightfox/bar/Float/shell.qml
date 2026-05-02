import QtQuick
import Quickshell
import "." 

ShellRoot {
    PanelWindow {
        // 1. Keep top anchor, but remove left and right anchors
        anchors.top: true
        
        // 2. Set your specific width
        width: 1000
        height: 38 
        
        // 3. Add a top margin to make the bar visually "float" away from the screen edge
        margins.top: 2

        // 4. Set the physical window background to transparent (required for rounded corners)
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            
            // 5. Use Qt.alpha to apply 0.55 opacity ONLY to the background color
            color: Qt.alpha(Colors.bg0, 0.90)
            
            // 6. Add a radius for rounded corners
            radius: 18

            Row {
                anchors.left: parent.left
                // Increased margin slightly so items don't clip into the rounded corners
                anchors.leftMargin: 15 
                anchors.verticalCenter: parent.verticalCenter
                Clock {} 
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Workspaces {} 
            }

            Row {
                anchors.right: parent.right
                // Increased margin slightly so items don't clip into the rounded corners
                anchors.rightMargin: 15 
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5

                NotificationWidget {}
                ClipboardWidget {}
                VolumeWidget {}
                WifiWidget {}
                BluetoothWidget {}
                Battery {}
                PowerWidget {}
            }
        }
        OsdWindow {}
    }
}
