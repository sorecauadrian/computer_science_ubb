using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FutureAndContinuation
{
    class HttpResponseParser
    {
        public int ContentLength { get; private set; } = -1;
        public bool HeadersComplete { get; private set; } = false;

        public void ParseHeaders(string response)
        {
            using (var reader = new StringReader(response))
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    if (string.IsNullOrWhiteSpace(line))
                    {
                        HeadersComplete = true;
                        break;
                    }

                    if (line.StartsWith("Content-Length:", StringComparison.OrdinalIgnoreCase))
                    {
                        string[] parts = line.Split(':');
                        if (parts.Length == 2 && int.TryParse(parts[1].Trim(), out int length))
                        {
                            ContentLength = length;
                        }
                    }
                }
            }
        }
    }
}
