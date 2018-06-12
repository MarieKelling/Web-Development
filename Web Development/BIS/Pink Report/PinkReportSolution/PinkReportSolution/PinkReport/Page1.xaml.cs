using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.OleDb;
using System.Configuration;
using System.Data; 

namespace PinkReport
{
    /// <summary>
    /// Interaction logic for Page1.xaml
    /// </summary>
    public partial class Page1 : Page
    {
        string SelectStatement = ("Select PINK, DateOut, JobID as JobNo, CustomerName as Company, ContactName as Contact, MfgName as Manufacturer, Description, " +
                                        "Model, SerialNumber as SerialNo, DateCompleted, EmployeeFirstName + ' ' + EmployeeLastName as CompletedBy, " +
                                        "EquipmentID as EID From CustomerContacts RIGHT JOIN " +
                                        "(Customers RIGHT JOIN (CustomerLocations RIGHT JOIN (((Equipment LEFT JOIN Employees ON " +
                                        "Equipment.CompletedByEmployeeID = Employees.EmployeeID) LEFT JOIN Manufacturers ON Equipment.ManufacturerID = Manufacturers.MfgID) " +
                                        "LEFT JOIN Jobs ON Equipment.RelatedJobID = Jobs.JobID) ON CustomerLocations.LocationID = Jobs.RelatedLocationID) " +
                                        "ON Customers.CustomerID = CustomerLocations.RelatedCustomerID) ON CustomerContacts.ContactID = Jobs.RelatedContactID ");

        public Page1()
        {
            InitializeComponent();
            LoadGrid1();
        }

        private void LoadGrid1()
        {
            var InitStartDate = DateTime.Today.ToString();      //Declare default start & end date values
            var InitEndDate = DateTime.Today.ToString();
            StartDate.Text = InitStartDate;                     //Set the start & end datepickers text value to the above default dates (the current day) 
            EndDate.Text = InitEndDate;

            OleDbConnection connection = new OleDbConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["BISEMConnectionString"].ToString();
            connection.Open();
            OleDbCommand command = new OleDbCommand(SelectStatement +
                                       "Where DateOut >=# " + StartDate.Text + "# " + " And DateOut <=# " +
                                                              EndDate.Text + "#", connection);
            //SelectStatement + "Where DateOut >=# " + InitStartDate + "#", connection); 

            OleDbDataReader reader = command.ExecuteReader();
            grid1.ItemsSource = reader;
        }

        private void BtnGo_Click(object sender, RoutedEventArgs e)
        {
            var AllSelected = (bool)RadioAll.IsChecked;         //Type cast 'bool?' to 'bool'
            var PinkSelected = (bool)RadioPinks.IsChecked;
            var NoPinkSelected = (bool)RadioNoPinks.IsChecked;

            OleDbConnection connection = new OleDbConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["BISEMConnectionString"].ToString();
            connection.Open();
            OleDbCommand command = new OleDbCommand(/*Query, Connection*/);

            //All
            if (AllSelected == true)
            {
                command.CommandText = (SelectStatement +
                                   "Where DateOut >=# " + StartDate.Text + "# " + " And DateOut <=# " +
                                                          EndDate.Text + "#");
            }
            //Pinks Received 
            else if (PinkSelected == true)
            {
                command.CommandText = (SelectStatement +
                                       "Where DateOut >=# " + StartDate.Text + "# " + " And DateOut <=# " +
                                                          EndDate.Text + "# " + " And PINK = true");
            }
            //Pinks Not Received 
            else if (NoPinkSelected == true)
            {
                command.CommandText = (SelectStatement +
                                   "Where DateOut >=# " + StartDate.Text + "# " + " And DateOut <=# " +
                                                          EndDate.Text + "# " + " And PINK = false");
            }
            //If user does not select a Show Option
            else
            {
                command.CommandText = (SelectStatement +
                                       "Where DateOut >=# " + StartDate.Text + "# " + " And DateOut <=# " +
                                                              EndDate.Text + "#");
            }
            command.Connection = connection;
            OleDbDataReader reader = command.ExecuteReader();
            grid1.ItemsSource = reader;
        }

        //Logic for admin passcode verification & PINKs being marked as true?
        private void BtnUpdate_Click(object sender, RoutedEventArgs e)
        {
            string AdminCode = "10001";
            string code = TxtAdminCode.Text;
            string UserEnetered = code;

            if (code == AdminCode)
            {
                int JobNo = Int32.Parse(TxtJobNo.Text);     //Cast to int because the DB is expecting an int 
                OleDbConnection connection = new OleDbConnection();
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["BISEMConnectionString"].ToString();
                connection.Open();
                OleDbCommand command1 = new OleDbCommand("Update Equipment Set PINK = true Where RelatedJobID = " + JobNo, connection);

                //MessageBox.Show("Update Submitted");
                command1.ExecuteNonQuery();
                MessageBox.Show("Update Complete");

                OleDbCommand command2 = new OleDbCommand();
                command2.CommandText = (SelectStatement + "Where DateOut >=# " + StartDate.Text + "# " + " And DateOut <=# " +
                                                                                     EndDate.Text + "# " + " And PINK = true");

                command2.Connection = connection;
                OleDbDataReader reader = command2.ExecuteReader();
                grid1.ItemsSource = reader;
            }
            else
            {
                MessageBox.Show("Code Invalid, Try Again");
            }
        }
    }
}
