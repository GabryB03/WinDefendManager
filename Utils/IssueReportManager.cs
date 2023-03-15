using System;
using System.Windows.Forms;

public class IssueReportManager
{
    public static void EmitIssueReport(Exception exception, bool onEnable)
    {
        string issueReportDetails = $"[-] Problem happened on specific action: {(onEnable ? "ENABLE" : "DISABLE")}.\r\n" +
            $"[-] Windows installation:{WindowsUtils.GetWindowsFriendlyName()}\r\n" +
            $"[-] Exception message: {exception.Message}\r\n" +
            $"[-] Exception stack trace: {exception.StackTrace}\r\n" +
            $"[-] Exception source: {exception.Source}\r\n" +
            $"[-] Exception help link: {exception.HelpLink}\r\n" +
            $"[-] Exception HResult: {exception.HResult}, 0x{exception.HResult.ToString("X2")}\r\n" +
            $"[-] Exception target site (method) full name: {exception.TargetSite.DeclaringType.FullName}.{exception.TargetSite.Name}\r\n" +
            $"[-] Complete UTC DateTime: " + DateTime.UtcNow.ToString();

        try
        {
            System.IO.File.WriteAllText("issue-report.txt", issueReportDetails);
        }
        catch
        {
            MessageBox.Show("Failed to make your 'issue-report.txt' file. Make sure there is no application using that file.",
                "WinDefendManager", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}