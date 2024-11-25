using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace FutureAndContinuation
{
    class HttpDownloaderEventDriven
    {
        public ManualResetEventSlim Done { get; } = new ManualResetEventSlim();
        public void Download(string url, int port)
        {
            var parser = new HttpResponseParser();
            var uri = new Uri(url);

            Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            socket.BeginConnect(uri.Host, port, asyncResult =>
            {
                try
                {
                    socket.EndConnect(asyncResult);

                    string request = $"GET {uri.PathAndQuery} HTTP/1.1\r\nHost: {uri.Host}\r\nConnection: close\r\n\r\n";
                    byte[] requestBytes = Encoding.ASCII.GetBytes(request);

                    socket.BeginSend(requestBytes, 0, requestBytes.Length, SocketFlags.None, sendResult =>
                    {
                        int bytesSent = socket.EndSend(sendResult);
                        Console.WriteLine(bytesSent);
                        byte[] buffer = new byte[8192];
                        StringBuilder responseBuilder = new StringBuilder();

                        void ReceiveCallback(IAsyncResult recvResult)
                        {
                            int bytesRead = socket.EndReceive(recvResult);
                            Console.WriteLine(bytesRead);
                            if (bytesRead > 0)
                            {
                                responseBuilder.Append(Encoding.ASCII.GetString(buffer, 0, bytesRead));
                                if (!parser.HeadersComplete)
                                {
                                    parser.ParseHeaders(responseBuilder.ToString());
                                }
                                socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, ReceiveCallback, null);
                            }
                            else
                            {
                                Console.WriteLine(responseBuilder.ToString());
                                socket.Close();
                                Done.Set();
                            }
                        }

                        socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, ReceiveCallback, null);
                    }, null);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error: {ex.Message}");
                    socket.Close();
                }
            }, null);
        }
        }
    }
