using DataValidationModule;

class Program
{
    static void Main(string[] args)
    {
        DataValidator validator = new DataValidator();

        string email1 = "test@example.com";
        bool isEmail1Valid = validator.ValidateEmail(email1);
        Console.WriteLine($"is the email {email1} valid? {isEmail1Valid}");

        string email2 = "@example.com.";
        bool isEmail2Valid = validator.ValidateEmail(email2);
        Console.WriteLine($"is the email {email2} valid? {isEmail2Valid}");

        string phoneNumber1 = "+1 (555) 123-4567";
        bool isPhoneNumber1Valid = validator.ValidatePhoneNumber(phoneNumber1);
        Console.WriteLine($"is the phone number {phoneNumber1} valid? {isPhoneNumber1Valid}");

        string phoneNumber2 = "123-456-7890";
        bool isPhoneNumber2Valid = validator.ValidatePhoneNumber(phoneNumber2);
        Console.WriteLine($"is the phone number {phoneNumber2} valid? {isPhoneNumber2Valid}");

        string phoneNumber3 = "abc123";
        bool isPhoneNumber3Valid = validator.ValidatePhoneNumber(phoneNumber3);
        Console.WriteLine($"is the phone number {phoneNumber3} valid? {isPhoneNumber3Valid}");

        string date1 = "14/04/2003";
        char format1 = '/';
        bool isDate1Valid = validator.ValidateDate(date1, format1);
        Console.WriteLine($"is the date {date1} with the format {format1} valid? {isDate1Valid}");

        string date2 = "06.10.2003";
        char format2 = '.';
        bool isDate2Valid = validator.ValidateDate(date2, format2);
        Console.WriteLine($"is the date {date2} with the format {format2} valid? {isDate2Valid}");

        string date3 = "31/02/2003";
        char format3 = '/';
        bool isDate3Valid = validator.ValidateDate(date3, format3);
        Console.WriteLine($"is the date {date3} with the format {format3} valid? {isDate3Valid}");

        string date4 = "14.14.2222";
        char format4 = '.';
        bool isDate4Valid = validator.ValidateDate(date4, format4);
        Console.WriteLine($"is the date {date4} with the format {format4} valid? {isDate4Valid}");

        string userInput = "';DROP TABLE Users;";
        string sanitizedInput = validator.SanitizeInput(userInput);
        Console.WriteLine($"sanitized input: {userInput} -> {sanitizedInput}");
    }
}