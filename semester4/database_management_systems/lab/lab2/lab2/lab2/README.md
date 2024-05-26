Transform your first lab to dynamically create the master-detail windows form. The form caption and stored procedures / queries used to access and manipulate data will be set in a configuration file.

You must prepare at least two different scenarios handling data from two different 1:n relationships.

The form should be generic enough such that switching between scenarios (i.e., updating the application to handle data from another 1:n relationship) can be achieved by simply updating the configuration file.

How you define and interpret the configuration file is entirely up to you.

You must use core ADO.NET (data sets, data adapters, data readers, etc.). Solutions using LINQ, Entity Framework, or any other ORM framework are not accepted.

Useful references:

* ADO.NET, data binding
  + seminars
  + http://www.youtube.com/playlist?list=PL364D9F01461F5F87
  + http://www.codeproject.com/Articles/24656/A-Detailed-Data-Binding-Tutorial
  + http://www.codeproject.com/Articles/8477/Using-ADO-NET-for-beginners
  + http://csharp-station.com/Tutorial/AdoDotNet/Lesson01

* XML files:
  + http://www.drdobbs.com/windows/parsing-xml-files-in-net-using-c/184416669
  + http://support.microsoft.com/kb/307548

* configuration files:
  + http://support.microsoft.com/kb/815786
  + http://msdn.microsoft.com/en-us/library/system.configuration.configuration.aspx
  + http://www.codeproject.com/Articles/6538/Configuration-Settings-File-for-providing-applicat
