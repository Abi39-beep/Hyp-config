import { App } from "astal/gtk3";
import Bar from "./src/Bar.tsx";

App.start({
  instanceName: "my-bar",
  main() {
    // Using a cast to prevent the 'get_monitors' error
    const monitors = (App as any).get_monitors();
    monitors.map((mon: any) => Bar(mon));
  },
});
