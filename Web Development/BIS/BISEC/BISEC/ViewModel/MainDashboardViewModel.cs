using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Input;
using System.Diagnostics;
using System.Windows;
using BISEC.Service;
using BISEC.View;
using BISCoreControl;

namespace BISEC.ViewModel
{
    public class MainDashboardViewModel : WorkspaceViewModel
    {
        #region Constructor
        public MainDashboardViewModel()
        {
            NotifyCompletedEquipment = CompletedCustomerEquipmentNotificationImplementation;
            ActiveNotifyPaymentOption = ActiveMissingPaymentOptionNotificationImplementation;
            PastDueNotifyPaymentOption = PastDueMissingPaymentOptionNotificationImplementation;
            NotifyEmployeeEquipment = EmployeeEquipmentNotificationImplementation;
            OpenRepairNotification = OpenRepairNotificationImplementation;
        }

        #endregion //Constructor

        #region Notification
        public Func<int> NotifyCompletedEquipment { get; set; }
        public Func<int> ActiveNotifyPaymentOption { get; set; }
        public Func<int> PastDueNotifyPaymentOption { get; set; }
        public Func<int> NotifyEmployeeEquipment { get; set; }
        public Func<int> OpenRepairNotification { get; set; }

        

        private static int ActiveMissingPaymentOptionNotificationImplementation()
        {
            if (BISEC.Properties.Settings.Default.NOTIFY_MISSING_PAYMENT_OPTION_SW == true)
            {
                //var r = new Random();
                //Thread.Sleep(1000);
                //return r.Next(1, 99);
                var r = -1;

                try
                {
                    r = PrivateHelper.GetMissingPaymentOptionCount(true);
                    Thread.Sleep(1000);
                }
                catch (Exception) { }

                return r;
            }
            else { return -1; }
        }

        private static int PastDueMissingPaymentOptionNotificationImplementation()
        {
            if (BISEC.Properties.Settings.Default.NOTIFY_MISSING_PAYMENT_OPTION_SW == true)
            {
                //var r = new Random();
                //Thread.Sleep(1000);
                //return r.Next(1, 99);
                var r = -1;

                try
                {
                    r = PrivateHelper.GetMissingPaymentOptionCount(false);
                    Thread.Sleep(1000);
                }
                catch (Exception) { }

                return r;
            }
            else { return -1; }
        }

        private static int CompletedCustomerEquipmentNotificationImplementation()
        {
            if (BISEC.Properties.Settings.Default.NOTIFY_COMPLETE_EQUIPMENT_SW == true)
            {
                var r = new Random();
                Thread.Sleep(2000);
                return r.Next(1, 99);
            }
            else { return -1; }
        }

        private static int EmployeeEquipmentNotificationImplementation()
        {
            if (BISEC.Properties.Settings.Default.NOTIFY_EQUIPMENT_QUEUE_SW == true)
            {
                var r = -1;

                try
                {
                    r = PrivateHelper.GetEmployeeEquipmentCount(App.CurrentUser.FullName);
                    Thread.Sleep(1000);
                }
                catch (Exception) { }

                return r;
            }
            else { return -1; }
        }

        private static int OpenRepairNotificationImplementation()
        {
            if (BISEC.Properties.Settings.Default.NOTIFY_OPEN_REPAIR_SW == true)
            {
                var r = -1;

                try
                {
                    r = PrivateHelper.GetOpenRepairCount();
                    Thread.Sleep(1000);
                }
                catch (Exception) { }

                return r;
            }
            else { return -1; }
        }
        #endregion //Notification


        #region Presentation
      

        public ICommand ShowQualityStatementCommand
        {
            get
            {
                if (_showQualityStatementCommand == null)
                    _showQualityStatementCommand = new RelayCommand(para=>this.ShowQualityStatement());
                return _showQualityStatementCommand;
            }
        }

        public ICommand OpenDatabaseCommand
        {
            get
            {
                if (_openDatabaseCommand == null)
                    _openDatabaseCommand = new RelayCommand(para => this.OpenDatabase(para));
                return _openDatabaseCommand;
            }
        }

        public ICommand OpenFileCommand
        {
            get
            {
                if (_openFileCommand == null)
                    _openFileCommand = new RelayCommand(para => this.OpenFile(para));
                return _openFileCommand;
            }
        }

        public ICommand ShowSettingWindowCommand
        {
            get
            {
                if (_showSettingWindowCommand == null)
                    _showSettingWindowCommand = new RelayCommand(para => this.ShowSettingWindow());
                return _showSettingWindowCommand;
            }
        }

        public ICommand OpenAdminDashboardCommand
        {
            get
            {
                if (_loadAdminDashboardCommand == null)
                    _loadAdminDashboardCommand = new RelayCommand(para => this.LoadAdminDashboard());
                return _loadAdminDashboardCommand;
            }
        }
        #endregion //Presentation

        #region Private helpers
        internal void ShowQualityStatement()
        {
            string msg = "Our Quality Statement" + Environment.NewLine + Environment.NewLine +
                Properties.Settings.Default.BIS_QUALITY_STATEMENT_1 + Environment.NewLine +
                Properties.Settings.Default.BIS_QUALITY_STATEMENT_2;
            PrivateHelper.ShowInfoMessage(msg);

            // test show ssrs report

        }

        internal void OpenDatabase(object dbName)
        {
            string shortcutName = string.Empty;
            bool opt2Install = false;
            bool pwProtected = false;
            bool okToOpen = true; 

            switch (dbName.ToString())
            {
                case "EM":
                    shortcutName = Properties.Resources.BISEM_FILE_PATH;
                    break;
                case "QC":
                    shortcutName = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Programs),
                                            "\\", Properties.Resources.PUBLISHER_NAME_HP, "\\", "BISQC", ".appref-ms");
                    opt2Install = true;
                    break;
                case "CA":
                    shortcutName = Properties.Resources.FILE_PATH_CORRECTIVE_ACTION;
                    pwProtected = true;
                    break;
                case "ET":
                    shortcutName = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Programs),
                                            "\\", Properties.Resources.PUBLISHER_NAME_BIS, "\\", Properties.Resources.SUITE_NAME, "\\", "TDM", ".appref-ms");;
                    opt2Install = true;
                    break;
                case "PO":
                    shortcutName = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Programs),
                                            "\\", Properties.Resources.PUBLISHER_NAME_BIS, "\\", Properties.Resources.SUITE_NAME, "\\", "Purchasing System", ".appref-ms");
                    opt2Install = true;
                    break;
                case "QT":
                    shortcutName = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Programs),
                                            "\\", Properties.Resources.PUBLISHER_NAME_BIS, "\\", Properties.Resources.SUITE_NAME, "\\", "QoSys", ".appref-ms");
                    opt2Install = true;
                    break;
            }

            // validate authentication for pw protected database
            if (pwProtected)
            {
                BISCoreControl.View.PasswordDialog passBox = new BISCoreControl.View.PasswordDialog("Enter your passcode: ");

                if (passBox.ShowDialog() == true)
                {
                    string passcode = passBox.Answer;

                    if (passcode != Properties.Settings.Default.ADMIN_CODE)
                    {
                        okToOpen = false;
                        PrivateHelper.ShowErrorMessage("Invalid passcode");
                    }
                }
            }

            // open database if it is ok
            if (okToOpen)
            {
                try
                {
                    Process.Start(shortcutName);
                }
                catch (Exception ex1)
                {
                    string msg = "Application Not Found. Would you like to install it?" + Environment.NewLine + Environment.NewLine + "Detail: " + ex1.Message ;
                    if (PrivateHelper.ShowYesNoMessage(msg) == true)
                    {
                        string installationPath = GetAppInstallationPath(dbName.ToString());

                        try { Process.Start(installationPath); }
                        catch (Exception ex) { PrivateHelper.ShowErrorMessage(ex.Message); }
                    }
                }
            }
        }

        internal void OpenFile(object fileName)
        {
            string filepath = GetFilePath(fileName.ToString());

            PrivateHelper.OpenFile(filepath);
        }

        internal void ShowSettingWindow()
        {
            BISCoreControl.View.PasswordDialog passBox = new BISCoreControl.View.PasswordDialog("Enter admin code: ");

            if (passBox.ShowDialog() == true)
            {
                string passcode = passBox.Answer;

                if (passcode != Properties.Settings.Default.ADMIN_CODE)
                {
                    PrivateHelper.ShowErrorMessage("Invalid passcode");
                }
                else
                {
                    SettingView win = new SettingView();
                    win.ShowDialog();
                }
            }

            
        }

        internal string GetAppInstallationPath(string appName)
        {
            string path = string.Empty;
            switch (appName)
            {
                case "ET":
                    path = Properties.Resources.TRAINING_APP_INSTALLATION_URL;
                    break;
                case "PO":
                    path = Properties.Resources.PO_APP_INSTALLATION_URL;
                    break;
                case "QT":
                    path = Properties.Resources.QT_APP_INSTALLATION_URL;
                    break;
                case "QC":
                    path = Properties.Resources.QC_APP_INSTALLATION_URL;
                    break;
            }
            return path;
        }

        internal string GetFilePath(string fileName)
        {
            string path = string.Empty;

            switch (fileName)
            {
                case "QMAN":
                    path = Properties.Resources.QUALITY_MANUAL_FILE_PATH;
                    break;
                case "EMPH":
                    path = Properties.Resources.EMP_HANDBOOK_FILE_PATH;
                    break;
                case "SAFETY":
                    path = Properties.Resources.SAFETY_HANDBOOK_FILE_PATH;
                    break;
                case "SCOPE":
                    path = Properties.Resources.SCOPE_FILE_PATH;
                    break;
                case "EBOK":
                    path = Properties.Resources.FILE_PATH_PROCEDURE_EBOOK;
                    break;
            }

            return path;
        }

        /// <summary>
        /// Load Admin dashboard
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void LoadAdminDashboard()
        {
            if (!App.IsTimesheetAdmin)
            {
                string msg = "You are not authorized to access this feature. Please contact admin for further assistance.";
                PrivateHelper.ShowInfoMessage(msg);
            }
            else
            {
                AdminDashboardViewModel vm = new AdminDashboardViewModel();
                AdminDashboard win = new AdminDashboard();
                
                win.DataContext = vm;
                win.Show();
            }
        }
        #endregion //Private helpers

        #region Fields
        public RelayCommand _showQualityStatementCommand,
            _openDatabaseCommand,
            _openFileCommand,
            _showSettingWindowCommand,
            _loadAdminDashboardCommand
            ;
            

        #endregion //Fields
    }
}
