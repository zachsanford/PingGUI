#
# PingGUI.ps1
#
# GUI for the ping command
#

Function Show-Interface () {   
    Add-Type -Name Window -Namespace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
    '
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr,0)

    Add-Type -AssemblyName System.Windows.Forms

    $Form = New-Object System.Windows.Forms.Form
    $Form.Text = "IP Pinger"
    $Form.TopMost = $true
    $Form.Width = 475
    $Form.Height = 425

    $execPing = New-Object System.Windows.Forms.Button
    $execPing.Text = "PING"
    $execPing.Width = 200
    $execPing.Height = 35
    $execPing.Add_Click({
        $userIP = $IP.Text
        $Results.Text = ping $userIP | Out-String
    })
    $execPing.location = New-Object System.Drawing.Point(130,322)
    $execPing.Font = "Microsoft Sans Serif,10"
    $Form.controls.Add($execPing)

    $Results = New-Object System.Windows.Forms.TextBox
    $Results.Text = ""
    $Results.Width = 375
    $Results.Height = 230
    $Results.Multiline = $true
    $Results.Location = New-Object System.Drawing.Point(42,20)
    $Results.Font = "Microsoft Sans Serif,10"
    $Form.Controls.Add($Results)

    $IP = New-Object System.Windows.Forms.TextBox
    $IP.Text = "Enter the IPv4 Address that you want to ping."
    $IP.Add_Click({
        $IP.Text = ""
    })
    $IP.Width = 375
    $IP.Height = 200
    $IP.Location = New-Object System.Drawing.Point(42,275)
    $IP.Font = "Microsoft Sans Serif,10"
    $Form.Controls.Add($IP)

    [void]$Form.ShowDialog()
    $Form.Dispose()
}

Show-Interface