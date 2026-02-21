import { Astal, Gtk, Gdk } from "astal/gtk3";
import Workspaces from "./widgets/Workspaces.tsx";
import Clock from "./widgets/Clock.tsx";

export default function Bar(monitor: Gdk.Monitor) {
  // We use cast (as any) to hide property errors in the editor
  const { TOP, LEFT, RIGHT } = (Astal as any).WindowAnchor;

  return (
    <window
      className="Bar"
      gdkmonitor={monitor}
      exclusivity={(Astal as any).Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
    >
      <centerbox>
        <box halign={Gtk.Align.START}>
          <Workspaces />
        </box>
        <box />
        <box halign={Gtk.Align.END}>
          <Clock />
        </box>
      </centerbox>
    </window>
  );
}
