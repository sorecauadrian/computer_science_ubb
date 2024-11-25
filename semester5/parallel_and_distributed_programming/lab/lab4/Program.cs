using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace FutureAndContinuation
{
    class Program
    {
        static async Task Main(string[] args)
        {
            string url = "http://httpforever.com/";
            int port = 80;

            Console.WriteLine("Event-driven approach:");
            var clinet=new HttpDownloaderEventDriven();
            clinet.Download(url, port);
            clinet.Done.Wait(); 
            
            Console.WriteLine("\nTask-wrapped approach:");
            var taskDownloader = new HttpDownloaderWithTasks();
            await taskDownloader.DownloadAsync(url, port);
        }
    }
}
