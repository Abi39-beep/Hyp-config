import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 8
    
    Repeater {
        model: [1, 2, 3, 4, 5] // Your 5 persistent workspaces
        
        Rectangle {
            required property int modelData
            width: 20; height: 20; radius: 5
            
            // LOGIC:
            // 1. Is this the one I'm currently on?
            readonly property bool isFocused: Hyprland.focusedWorkspace?.id === modelData
            
            // 2. Does this workspace have windows in it? 
            // We check if it exists in the active workspaces list.
            readonly property bool isOccupied: Hyprland.workspaces.values.some(ws => ws.id === modelData)

            // Dynamic Styling
            color: isFocused ? Colors.green : (isOccupied ? Colors.bg3 : Colors.bg1)
            border.width: isFocused ? 0 : 1
            border.color: isOccupied ? Colors.grey0 : Colors.bg2

            Text {
                anchors.centerIn: parent
                text: modelData
                font.pixelSize: 13
                font.bold: isFocused
                // Dark text on bright green, light text otherwise
                color: parent.isFocused ? Colors.bg0 : (parent.isOccupied ? Colors.fg : Colors.grey1)
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch(`workspace ${modelData}`)
            }
        }
    }
}