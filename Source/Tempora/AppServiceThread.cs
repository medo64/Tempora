using System;
using System.Threading;
using System.Net.Sockets;
using System.Net;
using System.Diagnostics;

namespace Tempora {

    internal static class AppServiceThread {

        private static Thread _thread;
        private static ManualResetEvent CancelationPendingEvent;


        public static void Start() {
            if (_thread != null) { return; }

            CancelationPendingEvent = new ManualResetEvent(false);
            _thread = new Thread(Run);
            _thread.Name = "Service";
            _thread.Start();
        }

        public static void Stop() {
            try {
                CancelationPendingEvent.Set();
                for (int i = 0; i < 10; ++i) {
                    if (_thread.IsAlive) {
                        Thread.Sleep(10);
                    } else {
                        break;
                    }
                }
                if (_thread.IsAlive) {
                    _thread.Abort();
                }
                _thread = null;
            } catch { }
        }


        private static bool IsCanceled { get { return CancelationPendingEvent.WaitOne(0, false); } }

        private static void Run() {
            try {
                var udpClient = new UdpClient(123);

                while (!IsCanceled) {
                    IPEndPoint remoteEP = null;
                    var inBuffer = udpClient.Receive(ref remoteEP);
                    DateTime arrival = DateTime.Now;
                    var ntp = NtpPacket.ParseBytes(inBuffer);

                    //Thread.Sleep(16);

                    var outBuffer = NtpPacket.GetBytes(DateTime.Now, ntp, arrival);
                    udpClient.Send(outBuffer, outBuffer.Length, remoteEP);
                }
            } catch (ThreadAbortException) { }
        }

    }

}
