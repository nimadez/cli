//
// GNOME 46: transparency is for dark theme only, see "stylesheet.css"
// CPU: set "/thermal_zone?/temp" number based on your setup
//

import GObject from 'gi://GObject';
import St from 'gi://St';
import GLib from 'gi://GLib';
import GTop from 'gi://GTop';
import Clutter from 'gi://Clutter';
import Shell from 'gi://Shell';

import { panel } from 'resource:///org/gnome/shell/ui/main.js';
import { Button } from 'resource:///org/gnome/shell/ui/panelMenu.js';
import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';

const Lang = imports.lang;
const Mainloop = imports.mainloop;

const MAX_INTERVAL = 1500;


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
    class HWINFO extends Button {
        _init() {
            super._init(0, 'Hardware Monitor');

            const box = new St.BoxLayout({ style_class: 'panel-status-menu-box' });
            const label_cpu = new St.Label({ text: '---% ---℃', x_expand: true, y_expand: true, x_align: Clutter.ActorAlign.CENTER, y_align: Clutter.ActorAlign.CENTER });
            const label_gpu = new St.Label({ text: '---℃ ---%', x_expand: true, y_expand: true, x_align: Clutter.ActorAlign.CENTER, y_align: Clutter.ActorAlign.CENTER });
            const label_mem = new St.Label({ text: '---% ---%', x_expand: true, y_expand: true, x_align: Clutter.ActorAlign.CENTER, y_align: Clutter.ActorAlign.CENTER });
            const formatter = new Intl.NumberFormat(undefined, { style: 'percent' });
            let prevCpu = new GTop.glibtop_cpu();

            this.add_style_class_name('panel-hwinfo');
            label_cpu.add_style_class_name('panel-hwinfo-label-cpu');
            label_gpu.add_style_class_name('panel-hwinfo-label-gpu');
            label_mem.add_style_class_name('panel-hwinfo-label-mem');
            box.add_child(label_cpu);
            box.add_child(label_gpu);
            box.add_child(label_mem);
            this.add_child(box);
            
            this.menu.addAction(_('Open System Monitor'), () => {
                Shell.AppSystem.get_default().lookup_app('org.gnome.SystemMonitor.desktop').activate();
            });

            function update() {
                const cpu = new GTop.glibtop_cpu();
                GTop.glibtop_get_cpu(cpu);
                const total = cpu.total - prevCpu.total;
                const user = cpu.user - prevCpu.user;
                const sys = cpu.sys - prevCpu.sys;
                const nice = cpu.nice - prevCpu.nice;
                prevCpu = cpu;

                exec('cat /sys/devices/virtual/thermal/thermal_zone2/temp').then((result) => {
                    label_cpu.set_text(`${formatter.format((user + sys + nice) / Math.max(total, 1.0))} ${result / 1000}℃`);
                });

                exec('nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader').then((temp) => {
                    exec('nvidia-smi --query-gpu=fan.speed --format=csv,noheader').then((fan) => {
                        temp = temp.replace('\n', '');
                        fan = fan.replace('\n', '');
                        fan = fan.replace(' ', '');
                        label_gpu.set_text(`${temp}℃ ${fan}`);
                    });
                });

                const mem = new GTop.glibtop_mem();
                const swap = new GTop.glibtop_swap();
                GTop.glibtop_get_mem(mem);
                GTop.glibtop_get_swap(swap);
                label_mem.set_text(`${formatter.format(mem.user / Math.max(mem.total, 1.0))} ${formatter.format(swap.used / Math.max(swap.total, 1.0))}`);
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


export default class PanelHwinfo extends Extension {
    constructor(metadata) {
        super(metadata);
        this._uuid = metadata.uuid;
    }

    enable() {
        this.hwinfo = new HWINFO();
        panel.addToStatusArea(this._uuid, this.hwinfo);
        panel.add_style_class_name('panel-transparency');
    }

    disable() {
        panel.remove_style_class_name('panel-transparency');
        this.hwinfo.destroy();
        this.hwinfo = null;
    }
}
