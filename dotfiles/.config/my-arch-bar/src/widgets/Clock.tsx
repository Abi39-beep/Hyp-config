import { Variable, GLib } from "astal";

export default function Clock() {
  const time = Variable("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format("%H:%M:%S")!,
  );

  return (
    <label className="Clock" label={time()} onDestroy={() => time.drop()} />
  );
}
