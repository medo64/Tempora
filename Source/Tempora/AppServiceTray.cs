using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Drawing;
using System.Reflection;
using System.Runtime.InteropServices;

namespace Tempora {

    internal class AppServiceTray {

        private static NotifyIcon TrayIcon;


        public static void Show() {
            TrayIcon = new NotifyIcon();
            TrayIcon.Icon = GetAppIcon();
            TrayIcon.Text = Medo.Reflection.CallingAssembly.Title + " " + Medo.Reflection.CallingAssembly.ShortVersionString;

            var mnuExit = new MenuItem("E&xit");
            mnuExit.Click += new EventHandler(mnuExit_Click);
            TrayIcon.ContextMenu = new ContextMenu(new MenuItem[] { mnuExit });

            TrayIcon.Visible = true;
        }

        private static void mnuExit_Click(object sender, EventArgs e) {
            AppServiceThread.Stop();
            TrayIcon.Visible = false; 
            Application.Exit();
        }



        private static Icon GetAppIcon() {
            System.IntPtr hLibrary = NativeMethods.LoadLibrary(Assembly.GetEntryAssembly().Location);
            if (!hLibrary.Equals(System.IntPtr.Zero)) {
                System.IntPtr hIcon = NativeMethods.LoadIcon(hLibrary, "#32512");
                if (!hIcon.Equals(System.IntPtr.Zero)) {
                    var icon = System.Drawing.Icon.FromHandle(hIcon);
                    if (icon != null) { return icon; }
                }
            }
            return null;
        }

        private static class NativeMethods {

            [DllImport("user32.dll", CharSet = CharSet.Unicode)]
            static extern internal IntPtr LoadIcon(IntPtr hInstance, string lpIconName);

            [DllImport("kernel32.dll", CharSet = CharSet.Unicode)]
            static extern internal IntPtr LoadLibrary(string lpFileName);

        }

    }

}
