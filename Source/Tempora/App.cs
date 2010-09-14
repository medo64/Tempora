using System;
using System.Configuration.Install;
using System.Diagnostics;
using System.Reflection;
using System.ServiceProcess;
using System.Windows.Forms;
using Medo.Application;
using Medo.Diagnostics;

namespace Tempora {

    internal static class App {

        [STAThread]
        private static void Main() {
            AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(CurrentDomain_UnhandledException);


            if (Args.Current.ContainsKey("Interactive")) {

                AppServiceThread.Start();
                AppServiceTray.Show();
                Application.Run();                

            } else if (Args.Current.ContainsKey("Install")) {

                ManagedInstallerClass.InstallHelper(new string[] { Assembly.GetExecutingAssembly().Location });

            } else if (Args.Current.ContainsKey("Uninstall")) {

                ManagedInstallerClass.InstallHelper(new string[] { "/u", Assembly.GetExecutingAssembly().Location });

            } else {

                ServiceBase.Run(new ServiceBase[] { AppService.Instance });

            }
        }


        private static void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e) {
            var text = ExceptionReport.GetText(e.ExceptionObject as Exception);
            Trace.TraceError(text);
#if !DEBUG
            Environment.Exit(1);
#endif
        }

    }

}
