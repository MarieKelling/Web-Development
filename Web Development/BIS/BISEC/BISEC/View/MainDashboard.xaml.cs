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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Threading;
using BISEC.ViewModel;
using BISEC.Service;
using BISCoreControl;
using BISCoreControl.Model;
using System.ComponentModel;

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for MainDashboard.xaml
    /// </summary>
    public partial class MainDashboard : Page
    {
        public MainDashboard()
        {
            InitializeComponent();

           
        }

        #region Buttons
        private void ReturnHomePageCommand(object sender, RoutedEventArgs e)
        {
            //this.mainFrame.Navigate(new MainPage()); 
        }

        private void OpenShippingDashboardCommand(object sender, RoutedEventArgs e)
        {
            //this.mainFrame.Navigate(new ShippingDashboard());
        }

        private void OpenOfficeDashboardCommand(object sender, RoutedEventArgs e)
        {
            //this.mainFrame.Navigate(new OfficeDashboard());
        }

        private void OpenMainPageCommand(object sender, RoutedEventArgs e)
        {
            //this.mainFrame.Navigate(new MainPage());
        }

        private void MinizeApp(object sender, RoutedEventArgs e)
        {
            var parent = Parent as NavigationWindow;
            if (parent != null)
                parent.WindowState = WindowState.Minimized;
        }

        private void ExitApp(object sender, RoutedEventArgs e)
        {
            string msg = "You are about to exit this application. Are you sure you want to do that?";

            if (PrivateHelper.ShowYesNoMessage(msg, "Exit Confirmaion") == true)
            {
                Application.Current.Shutdown();
            }
        }

        private void SwitchUser(object sender, RoutedEventArgs e)
        {
            LogonDialog2 logonDialog = new LogonDialog2(BISEC.Properties.Resources.APP_NAME + " | Switch User",
                                BISEC.Properties.Settings.Default.UserID);

            if (logonDialog.ShowDialog() == true)
            {
                // set current user
                App.SetCurrentUser(logonDialog.SelectedEmployee);
                
                // Display user name
                this.menuItemUserDisplayName.Header = App.CurrentUser.FullName;

                // Load Time Management Page
                this.mainFrame.HorizontalAlignment = HorizontalAlignment.Center;
                this.mainFrame.Navigate(new TimeManagementPage());
            }
        }

        private void OpenFolder(object sender, RoutedEventArgs e)
        {
            ///*
            string foldername = ((MenuItem)sender).Tag.ToString();
            string dirpath = GetFolderPath(foldername);

            ExplorerPage page = new ExplorerPage();

            ExplorerWindowViewModel viewModel = new ExplorerWindowViewModel(dirpath);
            page.DataContext = viewModel;

            this.mainFrame.HorizontalAlignment = HorizontalAlignment.Left;
            this.mainFrame.Navigate(page);
            //*/
        }

        private void OpenPhoneBook(object sender, RoutedEventArgs e) 
        {
            CompanyChartPage page= new CompanyChartPage();
            this.mainFrame.HorizontalAlignment = HorizontalAlignment.Left;
            this.mainFrame.Navigate(page);
        }

        private void OpenEquipmentList_Click(object sender, RoutedEventArgs e)
        {
            string eqListType = ((Button)sender).Tag.ToString();
            object vm = null;

            switch (eqListType)
            {
                case "MPTO-Active": //missing payment option
                    vm = new EquipmentListViewModel(EquipmentListType.MissingPaymentOption,true);
                    break;
                case "MPTO-PastDue": //missing payment option
                    vm = new EquipmentListViewModel(EquipmentListType.MissingPaymentOption,false);
                    break;
                case "OPR": //open repair
                    vm = new EquipmentListViewModel(EquipmentListType.OpenRepair,false);
                    break;
                case "EEQ": //employee equipment queue
                    vm = new EquipmentQueueViewModel();
                    break;
            }


            if (vm != null)
            {
                EquipmentListPage eqPage = new EquipmentListPage();
                eqPage.DataContext = vm;

                this.mainFrame.Navigate(eqPage);
            }
        }

        private void ButtonEmployeeEquipment_Click(object sender, RoutedEventArgs e)
        {
            EquipmentQueueViewModel vm = new EquipmentQueueViewModel();

            if (vm != null)
            {
                EquipmentQueueViewer eqPage = new EquipmentQueueViewer();
                eqPage.DataContext = vm;
                this.mainFrame.HorizontalAlignment = HorizontalAlignment.Left;
                this.mainFrame.Navigate(eqPage);
            }
        }
        #endregion //Buttons


        #region Private helper
        private void DatabasePanelVisibilitySwitch(object sender, RoutedEventArgs e)
        {
            if (this.DatabaseMenu.Visibility == Visibility.Collapsed)
                this.DatabaseMenu.Visibility = Visibility.Visible;
            else
                this.DatabaseMenu.Visibility = Visibility.Collapsed;
        }

        private void FolderPanelVisibilitySwitch(object sender, RoutedEventArgs e)
        {
            if (this.FolderMenu.Visibility == Visibility.Collapsed)
                this.FolderMenu.Visibility = Visibility.Visible;
            else
                this.FolderMenu.Visibility = Visibility.Collapsed;
        }

        private void QuickLinkPanelVisibilitySwitch(object sender, RoutedEventArgs e)
        {
            if (this.QuickLinkMenu.Visibility == Visibility.Collapsed)
                this.QuickLinkMenu.Visibility = Visibility.Visible;
            else
                this.QuickLinkMenu.Visibility = Visibility.Collapsed;
        }

        private void ToolPanelVisibilitySwitch(object sender, RoutedEventArgs e)
        {
            if (this.ToolMenu.Visibility == Visibility.Collapsed)
                this.ToolMenu.Visibility = Visibility.Visible;
            else
                this.ToolMenu.Visibility = Visibility.Collapsed;
        }

        internal string GetFolderPath(string folderName)
        {
            string path = string.Empty;

            switch (folderName)
            {
                case "WORK":
                    path = Properties.Resources.WORK_FOLDER_DIR;
                    break;
                case "ONSITE":
                    path = Properties.Resources.ONSITE_FOLDER_PATH + System.DateTime.Today.Year.ToString().Substring(2, 2); ;
                    break;
                case "CAL-FORM":
                    path = Properties.Resources.CALIBRATION_FORM_PATH;
                    break;
                case "MANUAL":
                    path = Properties.Resources.MANUAL_PATH;
                    break;
                case "QUALITY-FORM":
                    path = Properties.Resources.QUALITY_FORM_PATH;
                    break;
                case "SERVER":
                    path = Properties.Resources.SERVER_PATH;
                    break;
                case "A2LA":
                    path = Properties.Resources.A2LA_DOCUMENT_PATH;
                    break;
                case "WORK-HIS":
                    path = Properties.Resources.WORK_HISTORY_DIR;
                    break;
            }

            return path;
        }

        
        #endregion //Private helper

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            var vm = new MainDashboardViewModel();
            DataContext = vm;

            // Display user name
            this.menuItemUserDisplayName.Header = App.CurrentUser.FullName;

            //load initial page - the timesheet
            this.mainFrame.HorizontalAlignment = HorizontalAlignment.Center;
            this.mainFrame.Navigate(new TimeManagementPage());
            
        }

        /// <summary>
        /// Load Employee Timesheet
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void LoadTimesheet_Click(object sender, RoutedEventArgs e)
        {
            //var vm = new MainDashboardViewModel();
            //DataContext = vm;

            //// Display user name
            //this.menuItemUserDisplayName.Header = App.CurrentUser.FullName;

            //load initial page - the timesheet
            var frameContent = this.mainFrame.Content;

            if (!(frameContent is TimeManagementPage))
            {
                // prompt password for existing user or change user
                LogonDialog2 logonDialog = new LogonDialog2(BISEC.Properties.Resources.APP_NAME,
                                BISEC.Properties.Settings.Default.UserID);

                if (logonDialog.ShowDialog() == true)
                {
                    // set current user
                    App.SetCurrentUser(logonDialog.SelectedEmployee);

                    // Display user name
                    this.menuItemUserDisplayName.Header = App.CurrentUser.FullName;

                    // Load Time Management Page
                    this.mainFrame.HorizontalAlignment = HorizontalAlignment.Center;
                    this.mainFrame.Navigate(new TimeManagementPage());
                }
            }
        }


        /// <summary>
        /// Load Updater
        /// 2017-03-24
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void LoadUpdater_Click(object sender, RoutedEventArgs e)
        {
            Updater win = new Updater();
            win.ShowDialog();
        }

        
    }
}
