using MailKit.Net.Smtp;
using MimeKit;
using System.Net.Mail;
using System.Net;
using System.Threading.Tasks;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;
using DocumentFormat.OpenXml.Wordprocessing;
using Mailjet.Client;
using Newtonsoft.Json.Linq;
using Mailjet.Client.Resources;

namespace KLTN_YourLook.Interface
{
    public interface ISentMail
    {
        Task<bool> sentWithMailjet(string toEmail, string toName, string subject, string body);
    }
    public class SentMail : ISentMail
    {
        private readonly IConfiguration _config;
        public SentMail(IConfiguration config)
        {
            _config = config;
        }
        public async Task<bool> sentWithMailjet(string toEmail, string toName, string subject, string body)
        {
            var client = new MailjetClient("372b584be92764be6b343237c49207fe", "3292306ad9a0ab013d37be1789f26484");

            var request = new MailjetRequest
            {
                Resource = Send.Resource,
            }
            .Property(Send.Messages, new JArray {
                new JObject {
                    {"From", new JObject {
                        {"Email", "baokun959@gmail.com"}, // Địa chỉ này phải được xác minh trong Mailjet
                        {"Name", "YourLook"}
                    }},
                    {"To", new JArray {
                        new JObject {
                            {"Email", toEmail},
                            {"Name", toName}
                        }
                    }},
                    {"Subject", subject},
                    {"TextPart", body},
                    {"HTMLPart", $"<h3>{body}</h3>"}
                }
            });

            var response = await client.PostAsync(request);

            //if (!response.IsSuccessStatusCode)
            //{
            //    var errorInfo = response.GetErrorInfo();
            //    var raw = response.GetRawString();

            //    System.Diagnostics.Debug.WriteLine($"Status: {response.StatusCode}");
            //    System.Diagnostics.Debug.WriteLine($"Error Info: {errorInfo}");
            //    System.Diagnostics.Debug.WriteLine($"Raw: {raw}");

            //    // Gợi ý: log lỗi ra TempData để hiển thị thử
            //    TempData["MailError"] = $"Status: {response.StatusCode}, Error: {errorInfo}";
            //}
            return response.IsSuccessStatusCode;
        }
    }
}
