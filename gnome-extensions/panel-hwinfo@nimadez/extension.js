//
// 2024 @nimadez
//
// change "/thermal_zone?/temp" number based on your setup

const Main = imports.ui.main;
const PanelMenu = imports.ui.panelMenu;

const { GObject, St, Clutter, Gio, GLib } = imports.gi;
const Lang = imports.lang;
const Mainloop = imports.mainloop;

const MAX_INTERVAL = 5000;


async function exec(cmd) {
    return new Promise((resolve, reject) => {
        try {
            resolve(GLib.spawn_command_line_sync(cmd)[1].toString());
        } catch (e) {
            reject(e);
        }
    });
}


const HWINFO = GObject.registerClass(
    class HWINFO extends PanelMenu.Button {
        _init() {
            super._init(0, 'Hardware Monitor');

            const box = new St.BoxLayout({ style_class: 'panel-status-menu-box' });
            const label0 = new St.Label({ text: '--℃', x_expand: true, y_expand: true, x_align: Clutter.ActorAlign.CENTER, y_align: Clutter.ActorAlign.CENTER });
            const label1 = new St.Label({ text: '--℃', x_expand: true, y_expand: true, x_align: Clutter.ActorAlign.CENTER, y_align: Clutter.ActorAlign.CENTER });
            const label2 = new St.Label({ text: '---%', x_expand: true, y_expand: true, x_align: Clutter.ActorAlign.CENTER, y_align: Clutter.ActorAlign.CENTER });
            const label3 = new St.Label({ text: '---%', x_expand: true, y_expand: true, x_align: Clutter.ActorAlign.CENTER, y_align: Clutter.ActorAlign.CENTER });

            this.add_style_class_name('panel-hwinfo');
            label0.add_style_class_name('panel-hwinfo-label0');
            label1.add_style_class_name('panel-hwinfo-label1');
            label2.add_style_class_name('panel-hwinfo-label2');
            label3.add_style_class_name('panel-hwinfo-label3');
            box.add_child(label0);
            box.add_child(label1);
            box.add_child(label2);
            box.add_child(label3);
            this.add_child(box);

            function update() {
                exec('cat /sys/devices/virtual/thermal/thermal_zone2/temp').then((result) => {
                    label0.set_text(result / 1000 + "℃");
                });

                exec('nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader').then((result) => {
                    result = result.replace('\n', '');
                    label1.set_text(result + "℃");
                });

                exec('nvidia-smi --query-gpu=fan.speed --format=csv,noheader').then((result) => {
                    result = result.replace('\n', '');
                    result = result.replace(' ', '');
                    label2.set_text(result);
                });

                exec('free').then((result) => {
                    const lines = result.split('\n');
                    const freemem = lines[1].split(/[ ]+/);
                    const percmem = parseFloat(freemem[2]) * 100.0 / parseFloat(freemem[1]);
                    label3.set_text((percmem.toFixed(0) + '%').slice(-6));
                });
            }

            update();
            this._eventLoop = Mainloop.timeout_add(MAX_INTERVAL, Lang.bind(this, () => {
                update();
                return true;
            }));
        }

        _onDestroy() {
            Mainloop.source_remove(this._eventLoop);
            this.menu.removeAll();
            super._onDestroy();
        }
    }
)


class Extension {
    constructor(uuid) {
        this._uuid = uuid;
    }

    enable() {
        this.hwinfo = new HWINFO();
        Main.panel.addToStatusArea(this._uuid, this.hwinfo);
    }

    disable() {
        this.hwinfo.destroy();
        this.hwinfo = null;
    }
}


function init(meta) {
    return new Extension(meta.uuid);
}
