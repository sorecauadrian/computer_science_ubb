using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Sockets;

namespace FutureAndContinuation
{
    class HttpDownloaderWithTasks
    {
        public async Task DownloadAsync(string url, int port)
        {
            var parser = new HttpResponseParser();
            var uri = new Uri(url);

            using (Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp))
            {

                await Task.Factory.FromAsync(socket.BeginConnect, socket.EndConnect, uri.Host, port, null);

                string request = $"GET {uri.PathAndQuery} HTTP/1.1\r\nHost: {uri.Host}\r\nConnection: close\r\n\r\n";
                byte[] requestBytes = Encoding.ASCII.GetBytes(request);

                await Task.Factory.FromAsync(
                    (cb, state) => socket.BeginSend(requestBytes, 0, requestBytes.Length, SocketFlags.None, cb, state),
                    socket.EndSend,
                    null);

                byte[] buffer = new byte[8192];
                StringBuilder responseBuilder = new StringBuilder();

                int bytesRead;
                do
                {
                    bytesRead = await Task.Factory.FromAsync(
                        (cb, state) => socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, cb, state),
                        socket.EndReceive,
                        null);

                    if (bytesRead > 0)
                    {
                        responseBuilder.Append(Encoding.ASCII.GetString(buffer, 0, bytesRead));
                        if (!parser.HeadersComplete)
                        {
                            parser.ParseHeaders(responseBuilder.ToString());
                        }
                    }
                } while (bytesRead > 0);

                Console.WriteLine(responseBuilder.ToString());
            }
        }
    }
}
