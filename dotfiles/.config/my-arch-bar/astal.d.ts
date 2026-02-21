import "astal/gtk3";

declare global {
  export const Gdk: any;
  export const Gtk: any;
  export const Astal: any;
  namespace JSX {
    interface IntrinsicElements {
      [elem: string]: any;
    }
  }
}

declare module "gi://*" {
  const value: any;
  export default value;
}

declare module "astal/gtk3" {
  export const App: any;
  export const Astal: any;
  export const Gtk: any;
  export const Gdk: any;
}
