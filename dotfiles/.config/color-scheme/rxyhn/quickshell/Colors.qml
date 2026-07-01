pragma Singleton
import QtQuick

QtObject {
    // Rxyhn / Earthy Pine Base Background (derived from image_21.png)
    readonly property color bg0: "#012423"

    // UI hierarchy steps (stepping down into earthy, forest shades)
    readonly property color bg1: "#012423"
    readonly property color bg2: "#1C3A38"
    readonly property color bg3: "#122A28"
    readonly property color bg4: "#1A2F2B"

    // Foreground / Primary Text (Warm creamy ivory)
    readonly property color fg: "#FBD5AE"
    readonly property color fg0: "#FBD5AE"
    readonly property color fg1: "#E9C8A1"
    readonly property color fg2: "#CCAF8B"
    readonly property color fg3: "#A89279"

    // Accent and Context Colors (Shifted matte earthy tones)
    readonly property color red: "#D4493F"    // Softened terracotta red
    readonly property color orange: "#DB9D6F" // Matte clay orange
    readonly property color yellow: "#E5B73E" // Warm retro ochre yellow
    readonly property color green: "#90B640"  // Organic moss green
    readonly property color aqua: "#5EA89A"   // Soft washed teal/aqua
    readonly property color blue: "#3C7B80"   // Slate ocean blue
    readonly property color purple: "#694E68" // Dusty vintage plum/purple

    // Alternative UI greyscale/muted color mappings
    readonly property color grey0: "#DB9D6F" // Clay highlight
    readonly property color grey1: "#324440" // Warm slate-grey (line numbers)
    readonly property color grey2: "#435C56" // Soft outline tint
}
