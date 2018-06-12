using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Data;

using System.Text.RegularExpressions;
using BISEC.Model;

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for TimeSheetEntry.xaml
    /// </summary>
    public partial class MultiTimesheetView : Window
    {

        private string _UserLogin;
        
        public bool IsAdminMode { get; set; }

        public MultiTimesheetView()
        {
            InitializeComponent();
        }

        //public string UserLogin {
        //    get { return _UserLogin; }
        //    set { _UserLogin = value; }
        //}

        //public void SetActivityCombobox(DataTable inDataTable)
        //{
        //    AppControls.PopulateComboBox(ref this.cboActivities, inDataTable);
        //}

        //private void cboActivities_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        //{
        //    DataRowView dr = (DataRowView)this.cboActivities.SelectedItem;

        //    if (dr != null)
        //    {   
        //        if (dr["is_road_yn"].ToString() == "Y")
        //        {                    
        //            this.stkPanelCars.Visibility = Visibility.Visible;
        //            this.stkPanelClients.Visibility = Visibility.Visible;
        //            this.stkPanelTeam.Visibility = Visibility.Visible;
        //        }
        //        else
        //        {
        //            this.stkPanelCars.Visibility = Visibility.Collapsed;
        //            this.stkPanelClients.Visibility = Visibility.Collapsed;
        //            this.stkPanelTeam.Visibility = Visibility.Collapsed;
        //        }
        //        if (dr[1].ToString() == "OSRG")
        //        {
        //            this.stkPanelLunch.Visibility = Visibility.Visible;
        //        }
        //        else
        //        {
        //            this.stkPanelLunch.Visibility = Visibility.Collapsed;
        //        }

        //        if (dr[1].ToString() == "ISRG" && IsAdminMode==false)
        //        {
        //            this.txtStart.IsEnabled = false;
        //            this.txtFinish.IsEnabled = false;
        //        }
        //        else
        //        {
        //            this.txtStart.IsEnabled = true;
        //            this.txtFinish.IsEnabled = true;
        //        }

        //    }
        //}

        /*
        private void btnSubmit_Click(object sender, RoutedEventArgs e)
        {
            //this.txtErrStartTime.Text = null;
            this.txtErrEndTime.Text = null;
            this.txtErrClients.Text = null;
            this.txtErrCars.Text = null;
            this.txtErrActivities.Text = null;
            this.txtErrEndDate.Text = null;
            this.txtErrStartDate.Text = null;
            
            this._FormOnError = false;

            //DATimeManagement tm = new DATimeManagement();
            
            try
            {
                string  tStart = null,
                        tEnd = null,
                        activityCode = null;
                int? clientId = null,
                        carId = null;
                int lunchMins = 0;
                                
                // validate inputs
                if (this.cboActivities.Text == "")
                {
                    this.txtErrActivities.Text = "Tell us what activity this is";
                    _FormOnError = true;
                }
                else {
                    DataRowView drv = (DataRowView)this.cboActivities.SelectedItem;
                    if (drv != null) { activityCode = drv[1].ToString(); }
                }

                if (this.stkPanelCars.Visibility == Visibility.Visible)
                {
                    DataRowView drv = (DataRowView)this.cboCars.SelectedItem;
                    if (drv == null)
                    {
                        this.txtErrCars.Text = "Tell us which car you drove for this job";
                        _FormOnError = true;
                    }
                    else
                    {                        
                        carId = Convert.ToInt16(drv[1]);
                    }
                }

                if (this.stkPanelClients.Visibility == Visibility.Visible)
                {
                    DataRowView drv = (DataRowView)this.cboClients.SelectedItem;
                    if (drv == null)
                    {
                        this.txtErrClients.Text = "Please tell us the client that you perform the job for";
                        _FormOnError = true;
                    }
                    else
                    {                        
                        clientId = Convert.ToInt16(drv[1]);
                    }
                }

                if (this.dtpStartDate.Text == "" && !string.IsNullOrEmpty(this.txtStart.Text))
                {
                    this.txtErrStartDate.Text = "Missing start date";
                    _FormOnError = true;
                }

                if (this.dtpEndDate.Text == "" && !string.IsNullOrEmpty(this.txtFinish.Text)) {
                    this.txtErrEndDate.Text = "Missing end date";
                    _FormOnError = true;
                }
                
                if (this.stkStartTime.Visibility == Visibility.Visible)
                {
                    tStart = this.txtStart.Text;
                    Match timeMatch = Regex.Match(tStart, DataConnection.TwelveHourRegex,RegexOptions.IgnoreCase);

                    if (string.IsNullOrEmpty(tStart))
                    {
                        //if (AppInfo.ShowYesNoMessage("It appears that you forgot the start time. Do you want to continue without start time?") == MessageBoxResult.No) { return; }
                        this.txtErrStartDate.Text = "Mising start date";
                        _FormOnError = true;
                    }

                    if (!timeMatch.Success && !string.IsNullOrEmpty(tStart))
                    {
                        this.txtErrStartTime.Text = "The Start time is not set correctly.";
                        _FormOnError = true;
                    }
                }

                if (this.stkEndTime.Visibility == Visibility.Visible)
                {
                    tEnd = this.txtFinish.Text;
                    Match timeMatch = Regex.Match(tEnd, DataConnection.TwelveHourRegex,RegexOptions.IgnoreCase);

                    if (string.IsNullOrEmpty(tEnd))
                    {
                        //if (AppInfo.ShowYesNoMessage("It appears that you forgot the end time. Do you want to continue without end time?") == MessageBoxResult.No) { return; }
                        this.txtErrEndDate.Text = "Missing end date";
                        _FormOnError = true;
                    }

                    if (!timeMatch.Success && !string.IsNullOrEmpty(tEnd))
                    {
                        this.txtErrEndTime.Text = "The Start time is not set correctly.";
                        _FormOnError = true;
                    }
                }

                if (this.stkPanelLunch.Visibility == Visibility.Visible)
                {
                    if (string.IsNullOrEmpty(this.txtLunch.Text))
                    {
                        lunchMins = 0;
                    }
                    else
                    {
                        lunchMins = Convert.ToInt16(this.txtLunch.Text);
                    }
                }

                // add record if no error is found
                if (_FormOnError == false)
                {
                    bool rslt =
                    DATimeManagement.AddActivityLog(this.UserLogin,
                            this.dtpStartDate.Text, tStart,
                            this.dtpEndDate.Text, tEnd,
                            activityCode, clientId, carId, this.txtComment.Text,lunchMins);
                    if (rslt == true) { this.Close(); }
                }
            }

            catch (Exception ex)
            {
                AppInfo.ShowErrorMessage("Failed to save this: " + Environment.NewLine + ex.Message);
            }
            finally {
                tm = null;
            }
        }

        //*/

        //private void AllDayCheckBox_Checked(object sender, RoutedEventArgs e)
        //{
        //    this.stkStartTime.Visibility = Visibility.Collapsed;
        //    this.stkEndTime.Visibility = Visibility.Collapsed;
        //    this.txtStart.Text = "";
        //    this.txtFinish.Text = "";
        //}

        //private void AllDayCheckBox_UnChecked(object sender, RoutedEventArgs e)
        //{
        //    this.stkStartTime.Visibility = Visibility.Visible;
        //    this.stkEndTime.Visibility = Visibility.Visible;
        //    this.txtStart.Text = "";
        //    this.txtFinish.Text = "";
        //}

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        /*
        private void InitializeFormData()
        {
            DATimeManagement tm = new DATimeManagement();
            try
            {
                AppControls.PopulateComboBox(ref this.cboActivities, DATimeManagement.ListOfPaidCategory());
                AppControls.PopulateComboBox(ref this.cboCars, DATimeManagement.ListOfCar(AppControls.GetAppCurrentUser()));
                AppControls.PopulateComboBox(ref this.cboClients, Customer.CustomerLocations());
                this.mcboEmployess.ItemsSource = BISEC.Codes.AppControls.ConvertTableToDictionary(Employee.ListOfEmployees(false));
            }
            catch (Exception ex)
            {
                AppInfo.ShowErrorMessage("Failed to load initial data: " + Environment.NewLine + ex.Message);
            }
            finally
            {
                tm = null;
            }
        }
        //*/
    }
}
