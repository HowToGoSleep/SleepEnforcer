# SleepEnforcer 🌙

**SleepEnforcer** is a lightweight Windows PowerShell script designed to enforce healthy computing habits by automatically putting your computer to sleep during designated nighttime hours.

If you wake the computer up during the enforced sleep window, the script will grant you a short, **configurable** "grace period" (e.g., 10 minutes) to finish what you have to do before the computer goes back to sleep.

## ✨ Features

* **Automated Sleep Enforcement:** Continuously monitors the time and puts the PC to sleep during your defined off-hours.

* **Grace Period:** Prevents immediate sleep loops if you *have* to wake the PC up during the sleep window.

* **Midnight Crossover Support:** Safely handles time windows that span across midnight (e.g., `21:30` to `05:00`).

* **Fully Configurable:** Easily tweak the start time, end time, grace period, and check intervals.

* **Background Execution:** Can be run completely invisibly without leaving a console window open.

## ⚙️ Configuration

Open `SleepEnforcer.ps1` in any text editor and modify the variables at the top of the script to match your desired schedule:

```
# ====================================================================
# CONFIGURATION VARIABLES
# ====================================================================
$SleepStartTimeStr    = "21:30"   # Sleep start time (24-hour format "HH:mm")
$SleepEndTimeStr      = "05:00"   # Sleep end time (24-hour format "HH:mm")
$GracePeriodMinutes   = 10        # Minutes to wait after waking up before enforcing sleep again
$CheckIntervalSeconds = 60        # Seconds to wait between time checks outside the sleep window
# ====================================================================

```

## 🚀 How to Run

If you run the `.ps1` file normally, a PowerShell window will stay open on your screen. To run SleepEnforcer silently in the background:

### Method 1: Direct Run

Right-click the `.ps1` file, click `Run`. That's it.

### Method 2: Using a Windows Shortcut

1. Right-click on your Desktop or in a folder and choose **New > Shortcut**.

2. Paste the following command into the location box (be sure to replace the path with your actual path to the script):

   ```
   powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Path\To\SleepEnforcer.ps1"
   
   ```

3. Name the shortcut (e.g., "Start SleepEnforcer") and finish.

4. Double-click the shortcut. The script is now monitoring your time in the background.

### Method 3: Run at Startup (Task Scheduler)
To have this run automatically every time you log in:

1. Open **Task Scheduler** in Windows.

2. Click **Create Basic Task** and name it "SleepEnforcer".

3. Set the trigger to **When I log on**.

4. Set the action to **Start a program**.

5. In "Program/script", type `powershell.exe`.

6. In "Add arguments", paste: `-WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Path\To\SleepEnforcer.ps1"`

7. Save the task.

## 🛑 How to Stop the Script

**For direct run:** Ctrl-C to kill it.

**Otherwise,** Because the script runs invisibly in the background, there is no window to close. To stop the script (you have a 10-minute window to do this if it just woke up during sleep hours):

1. Press `Ctrl + Shift + Esc` to open **Task Manager**.

2. Go to the **Processes** tab.

3. Scroll down to find **Windows PowerShell**.

4. Right-click it and select **End Task**.

## ⚠️ Notes

* **Execution Policy:** Windows restricts PowerShell scripts by default. The `-ExecutionPolicy Bypass` flag in the silent run commands above safely bypasses this for this specific script without changing your system-wide security settings.

## 📄 License

GPLv3
