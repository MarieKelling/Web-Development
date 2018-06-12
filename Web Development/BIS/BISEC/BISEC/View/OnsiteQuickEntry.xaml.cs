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
using System.Data;
using System.Text.RegularExpressions;
using BISEC.Model;
using BISEC.Service;

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for OnsiteQuickEntry.xaml
    /// </summary>
    public partial class OnsiteQuickEntry : Window
    {
        private int LoginID { get; set; }

        public OnsiteQuickEntry()
        {
            InitializeComponent();
            InitializeFormData();
        }

        public OnsiteQuickEntry(int inEmployeeID):this()
        {
            LoginID  = inEmployeeID;
        }

        private void InitializeFormData()
        {
            PrivateHelper.PopulateComboBox(ref this.cboLocation, DataService.CustomerLocations());
            PrivateHelper.PopulateComboBox(ref this.cboCar, DataService.ListOfCar(App.CurrentUser.EmployeeID ?? 0));
            this.mcboEmps.ItemsSource = PrivateHelper.ConvertTableToDictionary(DataService.ListOfEmployees(false));
        }

        private void ButtonCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ButtonSave_Click(object sender, RoutedEventArgs e)
        {
            int car_id = 0 , location_id = 0, mins = 0;
            string err_msg = string.Empty;
            string selected_names = string.Empty;
            string notes = string.Empty;
            
            DataRowView drv = (DataRowView)this.cboLocation.SelectedItem;
            if (drv != null)
            {
                location_id = (int)drv[1];
            }
            else 
            {
                err_msg = "Missing Location Info.";   
            }

            drv = (DataRowView)this.cboCar.SelectedItem;
            if (drv != null)
            {
                car_id = (int)drv[1];
                if (car_id == 0)
                    err_msg = err_msg + Environment.NewLine + "Missing Car Info.";
            }
            else
                err_msg = err_msg + Environment.NewLine + "Missing Car Info.";
            
            
            if (int.TryParse(this.txtLunch.Text,out mins) == true)
            {
                mins = Convert.ToInt16(this.txtLunch.Text);
            }
            else
            {
                mins = -1;
            }

            notes = this.txtNote.Text;

            //concate selected names into a string
            Dictionary<string, object> SelectedItems;
            SelectedItems = this.mcboEmps.SelectedItems;
            if (SelectedItems != null) { selected_names = string.Join(",", SelectedItems.Values); }

            //add to db
            if (location_id == 0 || car_id == 0 || mins < 0)
            {
                PrivateHelper.ShowErrorMessage("Please fix the following error(s): " + err_msg, "Add Failed");
            }
            else
            {
                bool rslt = DataService.UpdateOnsiteLog(LoginID, mins, car_id, location_id, notes,selected_names);
                if (rslt == true)
                {
                    this.Close();
                }
            }

            
        }
    }
}
