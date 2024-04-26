using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace DataValidationModule
{
    internal class DataValidator
    {
        public bool ValidateEmail(string email)
        {
            // ensuring the email is not empty
            if (email == "") return false;

            // ensuring there is only one '@' symbol
            int atSymbolCount = 0;
            foreach (char c in email) 
            {
                if (c == '@') atSymbolCount++;
                if (atSymbolCount > 1) return false;
            }
            if (atSymbolCount == 0) return false;

            // ensuring there is at least one character before and after '@'
            int atIndex = email.IndexOf("@");
            if (atIndex == 0 || atIndex == email.Length - 1) return false;

            // ensuring there is at least one '.' after '@' and it's not the last character
            int dotIndex = email.LastIndexOf(".");
            if (dotIndex != -1 && dotIndex < atIndex && dotIndex < email.Length - 1) return false;

            return true;
        }
        public bool ValidatePhoneNumber(string phoneNumber)
        {
            // ensuring the phone number is not empty
            if (phoneNumber == "") return false;

            string allowedCharacters = "+-()0123456789 ";

            // checking if the character in the phone number is allowed
            foreach (char c in phoneNumber)
                if (!allowedCharacters.Contains(c)) return false;

            return true;
        }
        public bool ValidateDate(string date, char delimiter) // the date should have the format dd[delimiter]mm[delimiter]yyyy, where delimiter can take only the values ['.', '/', '-']
        {
            // ensuring the date is not empty
            if (date == "") return false;

            // ensuring the date has the length of 10 (dd/mm/yyyy)
            if (date.Length != 10) return false;

            // ensuring the delimiter can take only the values '.', '/' or '-'
            if (delimiter != '-' && delimiter != '/' && delimiter != '.') return false;

            // parsing the date parts to integers
            string[] parts = date.Split(delimiter);
            if (parts.Length != 3) return false;

            int day = int.Parse(parts[0]);
            int month = int.Parse(parts[1]);
            int year = int.Parse(parts[2]);

            // checking the ranges of month and year
            if (year < 1000 || year > 2024 || month == 0 || month > 12) return false;

            int[] monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

            // adjusting for leap years
            if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
                monthLength[1] = 29;

            // checking the range of the day
            return day > 0 && day <= monthLength[month - 1];
        }
        public string SanitizeInput(string input)
        {
            // defining a list of harmful characters (i think there should be more characters tho)
            char[] harmfulCharacters = ['\'', ';', '<', '>', '='];
            
            // defining a string builder to construct the sanitized input
            StringBuilder sanitizedInput = new StringBuilder();

            // if a character is not harmful, we append it to the sanitized input
            foreach (char c in input)
                if (!harmfulCharacters.Contains(c)) sanitizedInput.Append(c);

            return sanitizedInput.ToString();
        }
    }
}
