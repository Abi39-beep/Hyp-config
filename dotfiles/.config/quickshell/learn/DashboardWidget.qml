import QtQuick
import QtQuick.Controls 
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland 
import Quickshell.Services.Pipewire
import Quickshell.Services.Notifications
import "."

Rectangle {
    id: dashWidget
    width: 30; height: 30; radius: 15
    color: dashPopup.visible ? Colors.blue : Colors.bg1 
    border.width: 1
    border.color: Colors.bg2

    Text {
        anchors.centerIn: parent
        text: "󰕮" 
        font.pixelSize: 15
        font.family: "JetBrainsMono Nerd Font"
        color: dashPopup.visible ? Colors.bg0 : Colors.fg 
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            dashPopup.visible = !dashPopup.visible;
            if (dashPopup.visible && dashWidget.showClipboard) {
                refreshClip.running = false;
                resetTimer.start();
            }
        }
    }

    // ==========================================
    // 0. GLOBAL SHORTCUT (POWER MENU)
    // ==========================================
    GlobalShortcut {
        name: "powermenu" 
        onPressed: {
            if (!powerMenuWindow.visible) {
                powerMenuWindow.visible = true
                bgDimmer.forceActiveFocus() 
                powerList.forceActiveFocus() 
            } else {
                powerMenuWindow.closeMenu()
            }
        }
    }

    // ==========================================
    // 1. DATA & LOGIC
    // ==========================================
    property bool showClipboard: false

    PwObjectTracker { objects: Pipewire.defaultAudioSink ? [Pipewire.defaultAudioSink] :[] }
    property var audio: Pipewire.defaultAudioSink?.audio
    property int volPercent: audio ? Math.round(audio.volume * 100) : 0
    property bool isMuted: audio ? audio.muted : false

    property int briPercent: 50 
    Timer {
        interval: 2000; running: true; repeat: true
        onTriggered: getBri.running = true
        Component.onCompleted: getBri.running = true 
    }
    Process {
        id: getBri
        command: ["brightnessctl", "-m"]
        stdout: SplitParser {
            onRead: data => {
                let parts = data.split(",");
                if (parts.length >= 4) { dashWidget.briPercent = parseInt(parts[3].replace("%", "")); }
            }
        }
    }

    Process { id: executor; property string currentCommand: ""; command:["bash", "-c", currentCommand] }
    property var actionModel:[
        { name: "Lock", icon: "", cmd: "$HOME/.config/hypr/hyprlock.sh" },
        { name: "Sleep", icon: "󰤄", cmd: "systemctl suspend" },
        { name: "Logout", icon: "󰍃", cmd: "hyprctl dispatch exit" },
        { name: "Power", icon: "", cmd: "systemctl poweroff" }
    ]

    Timer {
        id: resetTimer
        interval: 10
        onTriggered: {
            refreshClip.command =["bash", "-c", "cliphist list #" + Date.now()];
            refreshClip.fullOutput = ""; 
            refreshClip.running = true;
        }
    }
    ListModel { id: clipModel }
    Process {
        id: refreshClip
        command:["bash", "-c", "cliphist list"]
        property string fullOutput: ""
        stdout: SplitParser { onRead: data => { refreshClip.fullOutput += data + "\n"; } }
        onExited: {
            clipModel.clear();
            let lines = fullOutput.split("\n");
            fullOutput = ""; 
            let count = 0;
            for (let i = 0; i < lines.length; i++) {
                if (!lines[i].trim()) continue; 
                let sep = lines[i].indexOf('\t');
                if (sep !== -1) {
                    let id = lines[i].substring(0, sep);
                    let text = lines[i].substring(sep + 1);
                    clipModel.append({ "clipId": id, "clipText": text });
                    count++;
                    if (count >= 30) break; 
                }
            }
        }
    }

    NotificationServer {
        id: server
        onNotification: (notification) => { notification.tracked = true; }
    }

    Component {
        id: notifDelegate
        Rectangle {
            id: cardRoot
            width: parent ? parent.width : 320
            property bool isOsd: ListView.view === null
            property bool osdExpired: false
            
            visible: isOsd ? !osdExpired : true
            implicitHeight: visible ? (contentCol.implicitHeight + 24) : 0
            color: Colors.bg0
            border.color: (modelData && modelData.urgency === 2) ? Colors.red : Colors.blue
            border.width: 1; radius: 12

            Timer { interval: 5000; running: cardRoot.isOsd && modelData && modelData.urgency !== 2 && !cardRoot.osdExpired; onTriggered: cardRoot.osdExpired = true }

            Row {
                anchors.fill: parent; anchors.margins: 12; spacing: 10
                Column {
                    id: contentCol
                    width: parent.width - 34; spacing: 4
                    Row {
                        spacing: 6
                        Text { text: "󰎆"; color: Colors.blue; font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font" }
                        Text { text: (modelData && modelData.appName) ? modelData.appName : "System"; color: Colors.blue; font.pixelSize: 11; font.bold: true }
                    }
                    Text { text: (modelData && modelData.summary) ? modelData.summary : ""; color: Colors.fg; font.pixelSize: 13; font.bold: true; width: parent.width; wrapMode: Text.Wrap }
                    Text { text: ((modelData && modelData.body) ? modelData.body : "").replace(/<[^>]*>?/gm, ''); color: Colors.grey1; font.pixelSize: 12; width: parent.width; wrapMode: Text.Wrap; visible: text.length > 0 }
                }
            }

            Rectangle {
                anchors.right: parent.right; anchors.top: parent.top; anchors.margins: 12; width: 24; height: 24; radius: 4
                color: closeMouse.containsMouse ? Colors.red : "transparent"
                Text { anchors.centerIn: parent; text: "󰅖"; color: closeMouse.containsMouse ? Colors.bg0 : Colors.grey1; font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font" }
                MouseArea {
                    id: closeMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (cardRoot.isOsd) cardRoot.osdExpired = true;
                        else { if (modelData) try { modelData.dismiss(); } catch(e) {} }
                    }
                }
            }
        }
    }

    // ==========================================
    // 2. DASHBOARD POPUP WINDOW (FIXED FOR FOCUS STEALING)
    // ==========================================
    PanelWindow {
        id: dashPopup
        
        // 1. Stretch window across entire screen
        anchors { top: true; bottom: true; left: true; right: true }
        
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        
        WlrLayershell.layer: WlrLayer.Overlay 
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand 
        visible: false
        
        onVisibleChanged: { if (visible) bgRect.forceActiveFocus() }

        // 2. Invisible background that closes dashboard when clicked outside!
        MouseArea {
            anchors.fill: parent
            onClicked: dashPopup.visible = false
        }

        Rectangle {
            id: bgRect
            
            // 3. Margin controls set relative to the full screen
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 45      // Drops down from the top
            anchors.rightMargin: 15    // Stays away from the right edge
            width: 380; height: 600 
            
            color: Qt.alpha(Colors.bg0, 0.95); border.color: Colors.bg2; border.width: 1; radius: 16
            
            focus: true
            Keys.onEscapePressed: dashPopup.visible = false

            // 4. Catch clicks inside the dashboard so they don't accidentally click the transparent background!
            MouseArea { anchors.fill: parent }

            Column {
                anchors.fill: parent; anchors.margins: 15; spacing: 15

                // --- POWER OPTIONS ROW ---
                Row {
                    width: parent.width; spacing: 10
                    Repeater {
                        model: dashWidget.actionModel
                        Rectangle {
                            width: (parent.width - 30) / 4; height: 60; radius: 10
                            color: powerMouse.containsMouse ? Colors.bg2 : Colors.bg1; border.width: 1; border.color: Colors.bg2
                            Column {
                                anchors.centerIn: parent; spacing: 4
                                Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.icon; color: Colors.red; font.pixelSize: 18; font.family: "JetBrainsMono Nerd Font" }
                                Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.name; color: Colors.fg; font.pixelSize: 10; font.bold: true }
                            }
                            MouseArea {
                                id: powerMouse
                                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    dashPopup.visible = false;
                                    powerMenuWindow.visible = true;
                                    bgDimmer.forceActiveFocus();
                                    powerList.forceActiveFocus();
                                    powerMenuWindow.handleTrigger(index, modelData.cmd);
                                }
                            }
                        }
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Colors.bg2 }

                // --- SLIDERS ---
                Item {
                    width: parent.width; height: 45
                    Item {
                        width: parent.width; height: 20
                        Row { anchors.left: parent.left; spacing: 8
                            Text { text: dashWidget.isMuted ? "󰝟" : "󰕾"; color: Colors.blue; font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font"; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "Volume"; color: Colors.blue; font.pixelSize: 13; font.family: "JetBrainsMono Nerd Font"; anchors.verticalCenter: parent.verticalCenter }
                        }
                        Text { anchors.right: parent.right; text: dashWidget.volPercent + "%"; color: Colors.blue; font.pixelSize: 13; font.family: "JetBrainsMono Nerd Font" }
                    }
                    Slider {
                        id: volSlider
                        anchors.bottom: parent.bottom; width: parent.width; height: 24 
                        from: 0; to: 100
                        focusPolicy: Qt.NoFocus 
                        
                        value: dashWidget.volPercent
                        
                        onMoved: { if (dashWidget.audio) dashWidget.audio.volume = value / 100.0; }
                        onPressedChanged: { if (!pressed) Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", (value / 100.0).toFixed(2)]); }
                        
                        MouseArea {
                            anchors.fill: parent; acceptedButtons: Qt.NoButton
                            onWheel: (wheel) => {
                                let newVol = dashWidget.volPercent + (wheel.angleDelta.y > 0 ? 5 : -5);
                                newVol = Math.max(0, Math.min(100, newVol));
                                if (dashWidget.audio) dashWidget.audio.volume = newVol / 100.0;
                                Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", (newVol / 100.0).toFixed(2)]);
                            }
                        }
                        background: Rectangle {
                            x: volSlider.leftPadding; y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2; width: volSlider.availableWidth; height: 6; radius: 3; color: Colors.bg2
                            Rectangle { width: volSlider.visualPosition * parent.width; height: parent.height; color: Colors.blue; radius: 3 }
                        }
                        handle: Rectangle {
                            x: volSlider.leftPadding + volSlider.visualPosition * (volSlider.availableWidth - width); y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2; width: 16; height: 16; radius: 8; color: Colors.bg0; border.color: Colors.blue; border.width: 4
                        }
                    }
                }

                Item {
                    width: parent.width; height: 45
                    Item {
                        width: parent.width; height: 20
                        Row { anchors.left: parent.left; spacing: 8
                            Text { text: "󰃠"; color: Colors.orange; font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font"; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "Brightness"; color: Colors.orange; font.pixelSize: 13; font.family: "JetBrainsMono Nerd Font"; anchors.verticalCenter: parent.verticalCenter }
                        }
                        Text { anchors.right: parent.right; text: dashWidget.briPercent + "%"; color: Colors.orange; font.pixelSize: 13; font.family: "JetBrainsMono Nerd Font" }
                    }
                    Slider {
                        id: briSlider
                        anchors.bottom: parent.bottom; width: parent.width; height: 24 
                        from: 0; to: 100
                        focusPolicy: Qt.NoFocus
                        
                        value: dashWidget.briPercent
                        
                        onMoved: { dashWidget.briPercent = Math.round(value); }
                        onPressedChanged: { if (!pressed) Quickshell.execDetached(["brightnessctl", "set", Math.round(value) + "%"]); }
                        
                        MouseArea {
                            anchors.fill: parent; acceptedButtons: Qt.NoButton 
                            onWheel: (wheel) => {
                                let newBri = dashWidget.briPercent + (wheel.angleDelta.y > 0 ? 5 : -5);
                                newBri = Math.max(0, Math.min(100, newBri));
                                dashWidget.briPercent = newBri; 
                                Quickshell.execDetached(["brightnessctl", "set", newBri + "%"]);
                            }
                        }
                        background: Rectangle {
                            x: briSlider.leftPadding; y: briSlider.topPadding + briSlider.availableHeight / 2 - height / 2; width: briSlider.availableWidth; height: 6; radius: 3; color: Colors.bg2
                            Rectangle { width: briSlider.visualPosition * parent.width; height: parent.height; color: Colors.orange; radius: 3 }
                        }
                        handle: Rectangle {
                            x: briSlider.leftPadding + briSlider.visualPosition * (briSlider.availableWidth - width); y: briSlider.topPadding + briSlider.availableHeight / 2 - height / 2; width: 16; height: 16; radius: 8; color: Colors.bg0; border.color: Colors.orange; border.width: 4
                        }
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Colors.bg2 }

                // --- TAB SELECTOR ---
                Row {
                    width: parent.width; height: 30; spacing: 10
                    Rectangle {
                        width: (parent.width - 10) / 2; height: 30; radius: 6
                        color: !dashWidget.showClipboard ? Colors.bg2 : "transparent"
                        Row { anchors.centerIn: parent; spacing: 6
                            Text { text: "󰂚"; color: Colors.fg; font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font" }
                            Text { text: "Notifications"; color: Colors.fg; font.bold: true; font.pixelSize: 12 }
                        }
                        MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: dashWidget.showClipboard = false }
                    }
                    Rectangle {
                        width: (parent.width - 10) / 2; height: 30; radius: 6
                        color: dashWidget.showClipboard ? Colors.bg2 : "transparent"
                        Row { anchors.centerIn: parent; spacing: 6
                            Text { text: "󰅌"; color: Colors.fg; font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font" }
                            Text { text: "Clipboard"; color: Colors.fg; font.bold: true; font.pixelSize: 12 }
                        }
                        MouseArea { 
                            anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                            onClicked: { 
                                dashWidget.showClipboard = true;
                                refreshClip.running = false;
                                resetTimer.start();
                            } 
                        }
                    }
                }

                // --- LIST CONTENT AREA ---
                Item {
                    width: parent.width; height: parent.height - y
                    
                    Item {
                        anchors.fill: parent; visible: !dashWidget.showClipboard
                        Rectangle {
                            width: 70; height: 24; radius: 4; color: Colors.red
                            anchors.top: parent.top; anchors.right: parent.right; z: 2 
                            Text { anchors.centerIn: parent; text: "󰆴 Clear"; color: Colors.bg0; font.bold: true; font.pixelSize: 11; font.family: "JetBrainsMono Nerd Font" }
                            MouseArea {
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    try {
                                        let itemsToClear = server.trackedNotifications.values;
                                        for (let i = itemsToClear.length - 1; i >= 0; i--) itemsToClear[i].dismiss();
                                    } catch(err) {}
                                }
                            }
                        }

                        ListView {
                            id: notifList
                            anchors.fill: parent; anchors.topMargin: 34; clip: true; spacing: 8
                            model: server.trackedNotifications
                            delegate: notifDelegate
                        }
                        Text { anchors.centerIn: parent; text: "No new notifications"; color: Colors.grey0; font.pixelSize: 12; visible: notifList.count === 0 }
                    }

                    Item {
                        anchors.fill: parent; visible: dashWidget.showClipboard
                        Rectangle {
                            width: 70; height: 24; radius: 4; color: Colors.red
                            anchors.top: parent.top; anchors.right: parent.right; z: 2
                            Text { anchors.centerIn: parent; text: "󰆴 Clear"; color: Colors.bg0; font.bold: true; font.pixelSize: 11; font.family: "JetBrainsMono Nerd Font" }
                            MouseArea {
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                onClicked: { Quickshell.execDetached(["cliphist", "wipe"]); clipModel.clear(); }
                            }
                        }

                        ListView {
                            anchors.fill: parent; anchors.topMargin: 34; clip: true; spacing: 6
                            model: clipModel
                            delegate: Item {
                                width: parent.width; height: 40
                                Rectangle { anchors.fill: parent; radius: 6; color: itemMouse.containsMouse ? Colors.bg2 : "transparent" }
                                MouseArea {
                                    id: itemMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        let cmd = "cliphist list | awk -F $'\\t' '$1 == \"" + model.clipId + "\"' | cliphist decode | wl-copy";
                                        Quickshell.execDetached(["bash", "-c", cmd]);
                                        dashPopup.visible = false;
                                    }
                                }
                                Row {
                                    anchors.fill: parent; anchors.margins: 6; spacing: 8
                                    Text { text: model.clipText; color: Colors.fg; font.pixelSize: 12; width: parent.width - 64; anchors.verticalCenter: parent.verticalCenter; elide: Text.ElideRight; maximumLineCount: 2; wrapMode: Text.Wrap }
                                    Rectangle {
                                        width: 26; height: 26; radius: 4; color: copyMouse.containsMouse ? Colors.blue : Colors.bg3; anchors.verticalCenter: parent.verticalCenter
                                        Text { anchors.centerIn: parent; text: "󰆏"; color: copyMouse.containsMouse ? Colors.bg0 : Colors.fg; font.pixelSize: 13; font.family: "JetBrainsMono Nerd Font" }
                                        MouseArea {
                                            id: copyMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                let cmd = "cliphist list | awk -F $'\\t' '$1 == \"" + model.clipId + "\"' | cliphist decode | wl-copy";
                                                Quickshell.execDetached(["bash", "-c", cmd]);
                                                dashPopup.visible = false;
                                            }
                                        }
                                    }
                                    Rectangle {
                                        width: 26; height: 26; radius: 4; color: delMouse.containsMouse ? Colors.red : "transparent"; anchors.verticalCenter: parent.verticalCenter
                                        Text { anchors.centerIn: parent; text: "󰆴"; color: delMouse.containsMouse ? Colors.bg0 : Colors.grey1; font.pixelSize: 13; font.family: "JetBrainsMono Nerd Font" }
                                        MouseArea {
                                            id: delMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                let cmd = "cliphist list | awk -F $'\\t' '$1 == \"" + model.clipId + "\"' | cliphist delete";
                                                Quickshell.execDetached(["bash", "-c", cmd]);
                                                clipModel.remove(index);
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

    // ==========================================
    // 3. FULL SCREEN POWER MENU OVERLAY
    // ==========================================
    PanelWindow {
        id: powerMenuWindow
        
        anchors { top: true; bottom: true; left: true; right: true }
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        
        WlrLayershell.layer: WlrLayer.Overlay 
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
        
        visible: false
        
        property int activeIndex: -1
        property int countdown: 10
        
        function closeMenu() {
            visible = false
            activeIndex = -1
            countdownTimer.stop()
        }
        
        function executeAction(cmd) {
            countdownTimer.stop()
            executor.currentCommand = cmd
            executor.running = true
            closeMenu()
        }

        function handleTrigger(index, cmd) {
            if (activeIndex === index) {
                executeAction(cmd)
            } else {
                activeIndex = index
                countdown = 10
                countdownTimer.restart()
            }
        }

        Timer {
            id: countdownTimer
            interval: 1000
            repeat: true
            onTriggered: {
                powerMenuWindow.countdown--
                if (powerMenuWindow.countdown <= 0) {
                    let cmd = dashWidget.actionModel[powerMenuWindow.activeIndex].cmd
                    powerMenuWindow.executeAction(cmd)
                }
            }
        }

        Rectangle {
            id: bgDimmer
            anchors.fill: parent
            color: "#CC000000" 
            
            focus: true
            Keys.onEscapePressed: powerMenuWindow.closeMenu()

            MouseArea {
                anchors.fill: parent
                onClicked: powerMenuWindow.closeMenu()
            }

            ListView {
                id: powerList
                anchors.centerIn: parent
                width: (120 * 4) + (20 * 3) 
                height: 120
                orientation: ListView.Horizontal
                spacing: 20
                focus: true
                
                Keys.onEscapePressed: powerMenuWindow.closeMenu()
                Keys.onLeftPressed: currentIndex = Math.max(0, currentIndex - 1)
                Keys.onRightPressed: currentIndex = Math.min(count - 1, currentIndex + 1)
                
                Keys.onReturnPressed: {
                    let currentItem = dashWidget.actionModel[currentIndex]
                    powerMenuWindow.handleTrigger(currentIndex, currentItem.cmd)
                }

                model: dashWidget.actionModel

                delegate: Rectangle {
                    id: btnRect
                    width: 120; height: 120; radius: 16
                    color: Colors.bg0
                    
                    property bool isActive: powerMenuWindow.activeIndex === index
                    property bool isFocused: powerList.currentIndex === index && powerList.activeFocus
                    
                    border.width: isActive ? 2 : (isFocused ? 1 : 1)
                    border.color: isActive ? Colors.red : (isFocused ? Colors.blue : Colors.bg2)

                    Column {
                        anchors.centerIn: parent
                        spacing: 12

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: btnRect.isActive ? powerMenuWindow.countdown : modelData.icon
                            font.pixelSize: 40
                            font.family: "JetBrainsMono Nerd Font"
                            color: btnRect.isActive ? Colors.red : Colors.fg
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: btnRect.isActive ? "Confirm?" : modelData.name
                            font.pixelSize: 14
                            font.bold: true
                            color: Colors.fg
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        
                        onEntered: { powerList.currentIndex = index }
                        
                        onClicked: {
                            powerList.currentIndex = index
                            powerList.forceActiveFocus()
                            powerMenuWindow.handleTrigger(index, modelData.cmd)
                        }
                    }
                }
            }
            
            Text {
                anchors.top: powerList.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Click once or press Enter to start 10s timer. Double click to execute instantly.\nPress Esc or click outside to cancel."
                horizontalAlignment: Text.AlignHCenter
                color: Colors.grey1
                font.pixelSize: 12
            }
        }
    }

    // ==========================================
    // 4. FLOATING OSD (For New Notifications)
    // ==========================================
    PanelWindow {
        id: osdWindow
        anchors.top: true
        anchors.right: true
        margins.top: 45
        margins.right: 15
        
        implicitWidth: 335 
        implicitHeight: osdCol.implicitHeight > 0 ? (osdCol.implicitHeight + 60) : 1
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        visible: !dashPopup.visible 

        Column {
            id: osdCol
            width: 320; spacing: 10
            anchors.top: parent.top
            anchors.right: parent.right

            Repeater {
                model: server.trackedNotifications
                delegate: notifDelegate
            }
        }
    }
}
