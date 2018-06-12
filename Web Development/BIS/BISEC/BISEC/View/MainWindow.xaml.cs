using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Navigation;
using BISCoreControl;
using BISEC.ViewModel;

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : NavigationWindow
    {
        public MainWindow()
        {
            InitializeComponent();

            // verify username/password
            LogonDialog2 logonDialog = new LogonDialog2(BISEC.Properties.Resources.APP_NAME,
                                BISEC.Properties.Settings.Default.UserID);

            if (logonDialog.ShowDialog() == true)
            {
                // set current user
                App.SetCurrentUser(logonDialog.SelectedEmployee);

                if (Properties.Settings.Default.DoNotShowNewReleaseSplashScreenAtStartup == false)
                {
                    NewReleaseSplashScreen win = new NewReleaseSplashScreen();
                    win.ShowDialog();
                }
            }
            else
            {
                //exit app
                Application.Current.Shutdown();
            }
        }
    }
}
