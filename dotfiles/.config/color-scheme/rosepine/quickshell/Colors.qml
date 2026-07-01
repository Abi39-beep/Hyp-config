pragma Singleton
import QtQuick

QtObject {
    // Rosé Pine Base
    readonly property color bg0: "#191724" // Base
    readonly property color bg1: "#1f1d2e" // Surface
    readonly property color bg2: "#26233a" // Overlay
    readonly property color bg3: "#403d52" // Highlight Med
    readonly property color bg4: "#524f67" // Highlight High

    // Foreground / Text
    readonly property color fg: "#e0def4"  // Text
    readonly property color fg0: "#e0def4"
    readonly property color fg1: "#908caa" // Subtle
    readonly property color fg2: "#6e6a86" // Muted
    readonly property color fg3: "#524f67"

    // Accents
    readonly property color red: "#eb6f92"    // Love
    readonly property color orange: "#ebbcba" // Rose
    readonly property color yellow: "#f6c177" // Gold
    readonly property color green: "#31748f"  // Pine (Teal/Green)
    readonly property color aqua: "#9ccfd8"   // Foam (Cyan/Aqua)
    readonly property color blue: "#9ccfd8"   // Foam
    readonly property color purple: "#c4a7e7" // Iris

    // Greyscale / Muted
    readonly property color grey0: "#6e6a86"
    readonly property color grey1: "#403d52"
    readonly property color grey2: "#26233a"
}
