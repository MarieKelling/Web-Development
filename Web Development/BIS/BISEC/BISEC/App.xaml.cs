using BISCoreControl;
using BISCoreControl.Model;
using BISEC.View;
using BISEC.ViewModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace BISEC
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            //var startupForm = new Forms.TimeAdminWindow();
            //System.Diagnostics.Debugger.Break();
            try
            {
                //EquipmentSummary win = new EquipmentSummary(0);
                base.OnStartup(e);

                // prevent multiple instances running
                Process thisProc = Process.GetCurrentProcess();
                if (Process.GetProcessesByName(thisProc.ProcessName).Length > 1)
                {
                    MessageBox.Show("Application is already running");
                    Application.Current.Shutdown();
                    return;
                }

                MainWindow win = new MainWindow();
                win.Show();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        #region Methods
        public static void SetCurrentUser(EMPLOYEE user)
        {
            CurrentUser = user;
            BISEC.Properties.Settings.Default.UserID = user.EmployeeID ?? 0;
            BISEC.Properties.Settings.Default.Save();

            IsTimesheetAdmin = BISCoreControl.Authorization.VerifyEmployeeRole(user.EmployeeID ?? 0, BISEC.Properties.Settings.Default.TIMESHEET_ADMIN_ROLE_ID);
        }

        #endregion //Methods

        #region App Properties
        public static EMPLOYEE CurrentUser = null;
        public static bool IsTimesheetAdmin = false;
        #endregion //App Properties
    }
}
