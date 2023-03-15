using MetroSuite;
using System;
using System.Diagnostics;
using System.Threading;
using System.Windows.Forms;

public partial class MainForm : MetroForm
{
    public MainForm()
    {
        InitializeComponent();
        CheckForIllegalCrossThreadCalls = false;
        Process.GetCurrentProcess().PriorityClass = ProcessPriorityClass.RealTime;
        new Thread(IncrementOpacity).Start();
    }

    public void IncrementOpacity()
    {
        Thread.Sleep(10);

        while (Opacity != 1.0)
        {
            Thread.Sleep(70);
            Opacity += 0.075;
        }
    }

    private void guna2Button1_Click(object sender, System.EventArgs e)
    {
        if (MessageBox.Show("Are you sure you want to enable Windows Defender Antivirus? (Confirmation 1/3)",
            "WinDefendManager", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
        {
            if (MessageBox.Show("Are you sure you want to enable Windows Defender Antivirus? (Confirmation 2/3)",
                "WinDefendManager", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (MessageBox.Show("Are you sure you want to enable Windows Defender Antivirus? (Confirmation 3/3)",
                    "WinDefendManager", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    try
                    {
                        ToggleWindowsDefender(true);
                        MessageBox.Show("Succesfully enabled Windows Defender Antivirus!\r\n" +
                            "Restart (not shutdown) your system now in order to apply the changes.", "WinDefendManager",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    catch (Exception exception)
                    {
                        IssueReportManager.EmitIssueReport(exception, true);
                        MessageBox.Show("Failed to enable Windows Defender Antivirus. Please, open an issue in GitHub by clicking on the bottom text of the program, and send your issue-report.txt details.",
                            "WinDefendManager", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }
    }

    private void guna2Button2_Click(object sender, System.EventArgs e)
    {
        if (MessageBox.Show("Are you sure you want to disable Windows Defender Antivirus? (Confirmation 1/3)",
            "WinDefendManager", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
        {
            if (MessageBox.Show("Are you sure you want to disable Windows Defender Antivirus? (Confirmation 2/3)",
                "WinDefendManager", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (MessageBox.Show("Are you sure you want to disable Windows Defender Antivirus? (Confirmation 3/3)",
                    "WinDefendManager", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    try
                    {
                        ToggleWindowsDefender(false);
                        MessageBox.Show("Succesfully disabled Windows Defender Antivirus!\r\n" +
                            "Restart (not shutdown) your system now in order to apply the changes.", "WinDefendManager",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    catch (Exception exception)
                    {
                        IssueReportManager.EmitIssueReport(exception, false);
                        MessageBox.Show("Failed to disable Windows Defender Antivirus. Please, open an issue in GitHub by clicking on the bottom text of the program, and send your issue-report.txt details.",
                            "WinDefendManager", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }
    }

    public void ToggleWindowsDefender(bool toggle)
    {
        if (toggle)
        {
            WinDefendControl.EnableWindowsDefender();
        }
        else
        {
            WinDefendControl.DisableWindowsDefender();
        }
    }

    private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
    {
        try
        {
            Process.Start("https://github.com/GabryB03/WinDefendManager/");
        }
        catch
        {
            MessageBox.Show("https://github.com/GabryB03/WinDefendManager/", "WinDefendManager",
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}