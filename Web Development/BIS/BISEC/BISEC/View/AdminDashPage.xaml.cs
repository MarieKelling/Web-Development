
//using System;
//using System.Data;
//using System.Windows;
//using System.Windows.Controls;
//using System.ComponentModel; //for Ilistsource
//using System.Collections.Generic;
//using BISEC.Model;
//using BISEC.Service;

//namespace BISEC.View
//{
//    /// <summary>
//    /// Interaction logic for TimeAdminWindow.xaml
//    /// </summary>
//    public partial class AdminDashPage : Window
//    {
//        private string SelectedEmployeeLogin { get; set; }

//        public AdminDashPage()
//        {
//            InitializeComponent();
            
//            //initialize selected date and get summary data
//            DateTime startDate = DateTime.Now.AddDays(-7).StartOfWeek(DayOfWeek.Monday);
//            this.dtpStartDate.SelectedDate = startDate;
//            this.dtpEndDate.SelectedDate = DateTime.Now.AddDays(-1);
//            this.LoadSummaryData();
            
//            //override RowDetailsVisibilityChanged
//            this.dgSummary.RowDetailsVisibilityChanged += new EventHandler<System.Windows.Controls.DataGridRowDetailsEventArgs>
//                                                          (dgSummary_RowDetailsVisibilityChanged);
            
//            //add expand button to the summary grid
//            //((App)Application.Current).CreateExpandButtonForDataGrid(ref this.dgSummary);
//            this.CreateAddNewButtonForSummaryGrid(this.dgSummary);
            
//            //this.dgSummary.LoadingRow += new EventHandler<System.Windows.Controls.DataGridRowEventArgs>(dgSummary_LoadingRow);
//            //this.dgSummary.UnloadingRow += new EventHandler<System.Windows.Controls.DataGridRowEventArgs>(dgSummary_UnloadingRow);
//        }
               

//        #region Events

//        /// <summary>
//        /// Pull detail row based on selected user from summary grid and selected date range from parents form.
//        /// </summary>
//        /// <param name="sender"></param>
//        /// <param name="e"></param>
//        private void dgSummary_RowDetailsVisibilityChanged(object sender, System.Windows.Controls.DataGridRowDetailsEventArgs e)
//        {
//            // load detail data
//            try
//            {
//                if (e.Row.Visibility == Visibility.Visible)
//                {
//                    DateTime startDate, endDate;
//                    string userLogin;

//                    //if (startDate == null || endDate == null)
//                    //{
//                    //    AppInfo.ShowWarningMessage("No date selected");
//                    //}
//                    //else
//                    {
//                        DataRowView drv = (DataRowView)e.Row.DataContext;
//                        userLogin = drv["loginname"].ToString();
//                        startDate = Convert.ToDateTime(drv["startdate"].ToString());
//                        endDate = Convert.ToDateTime(drv["enddate"].ToString());

//                        DataTable detailDataTable = DATimeManagement.GetEmpDailyDetail(userLogin, startDate, endDate);

//                        // bind data
//                        System.Windows.Controls.DataGrid detailDataGrid = e.DetailsElement as System.Windows.Controls.DataGrid;
//                        detailDataGrid.Columns.Clear();
//                        //if (_EditButtonCreated != true) { this.CreateEditButtonForDetailGrid(ref detailDataGrid); _EditButtonCreated = true; }
//                        detailDataGrid.ItemsSource = ((IListSource)detailDataTable).GetList();
//                        // add button for grid
//                        ((App)Application.Current).CreateEditButtonForDetailGrid(ref detailDataGrid);
//                        this.CreateApproveButtonColumn(ref detailDataGrid);
//                        this.CreateApproveStatusColumn(ref detailDataGrid);
//                    }
//                }
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to load detail data: " + ex.Message);
//            }
            
//        }

//        private void dgEmployees_RowDetailsVisibilityChanged(object sender, System.Windows.Controls.DataGridRowDetailsEventArgs e)
//        {
//            // load detail data
//            try
//            {
//                if (e.Row.Visibility == Visibility.Visible)
//                {
//                    DataRowView drv = (DataRowView)e.Row.DataContext;
//                    string userLogin = drv["login"].ToString();
//                    DataTable detailDataTable = DAEmployee.GetEmployeeRolesByLogin(userLogin);

//                    // bind data
//                    System.Windows.Controls.DataGrid detailDataGrid = e.DetailsElement as System.Windows.Controls.DataGrid;
//                    detailDataGrid.Columns.Clear();
//                    //if (_EditButtonCreated != true) { this.CreateEditButtonForDetailGrid(ref detailDataGrid); _EditButtonCreated = true; }
//                    detailDataGrid.ItemsSource = ((IListSource)detailDataTable).GetList();
//                    // add button for grid
                    
//                 }
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to load detail data: " + ex.Message);
//            }

//        }

//        void btnViewSummary_Click(object sender, RoutedEventArgs e) 
//        { 
//            this.LoadSummaryData();
//        }

//        //Hide the LoginName column in summary grid
//        void SummaryGrid_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
//        {
//            if (e.Column.Header.ToString().ToLower() == "loginname" ||
//                e.Column.Header.ToString().ToLower() == "needattention")
//            {
//                e.Column.Visibility = Visibility.Hidden;
//            }
//        }

//        void DetailGrid_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
//        {
            
//            if (e.Column.Header.ToString().ToLower() == "id" ||
//                e.Column.Header.ToString().ToLower() == "siteid" ||
//                e.Column.Header.ToString().ToLower() == "carid" ||
//                e.Column.Header.ToString().ToLower() == "activitycode" ||
//                e.Column.Header.ToString().ToLower() == "status")
//            {
//                e.Column.Visibility = Visibility.Hidden;
//            }
//        }

//        void Generic_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
//        {
//            DataGrid datagrid = (DataGrid)sender;
            
//            if (datagrid.Name=="dgCustomerLocation")
//            {
//                if (e.Column.Header.ToString().ToLower() == "locationid" ||
//                    e.Column.Header.ToString().ToLower() == "customerid")
//                {
//                    e.Column.Visibility = Visibility.Hidden;
//                }
//            }
//        }

//        private void dgSummary_LoadingRow(object sender, DataGridRowEventArgs e)
//        {
//            //if (button != null) button.Click += new RoutedEventHandler(DatagridDropdownButton);
//        }

//        private void dgSummary_UnloadingRow(object sender, DataGridRowEventArgs e)
//        {
//            //Button button = this.dgSummary.Columns[0].GetCellContent(e.Row) as Button;
//            //if (button != null) button.Click -= new RoutedEventHandler(DatagridDropdownButton_Click);
//        }
        
//        private void dgEmployeeRoles_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
//        {
//            if (e.Column.Header.ToString().ToLower() == "roleid")
//            {
//                e.Column.Visibility = Visibility.Hidden;
//            }
//        }

//        private void ButtonVacationDetail(object sender, RoutedEventArgs e)
//        {
//            try
//            {
//                DateTime dtEnd = Convert.ToDateTime(this.dtpSelectedDate.Text);
//                DateTime dtStart = Convert.ToDateTime("1/1/" + dtEnd.Year.ToString());

//                DataDetail win = new DataDetail(dtStart, dtEnd, this.SelectedEmployeeLogin, "VACA");
//                win.ShowDialog();
               
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to load detail: " + ex.Message);
//            }
//        }

//        private void ButtonSickDetail(object sender, RoutedEventArgs e)
//        {
//            try
//            {
//                DateTime dtEnd = Convert.ToDateTime(this.dtpSelectedDate.Text);
//                DateTime dtStart = Convert.ToDateTime(@"1/1/" + dtEnd.Year.ToString());
//                DataDetail win = new DataDetail(dtStart, dtEnd, this.SelectedEmployeeLogin, "SICK");
//                win.ShowDialog();
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to load detail: " + ex.Message);
//            }
//        }

//        private void ButtonRolloverHistory(object sender, RoutedEventArgs e)
//        {
//            try
//            {
//                //DateTime dtEnd = Convert.ToDateTime(this.dtpSelectedDate.Text);
//                //DateTime dtStart = Convert.ToDateTime(@"1/1/" + dtEnd.Year.ToString());
//                VacationRolloverHistory win = new VacationRolloverHistory(this.SelectedEmployeeLogin as string);
//                win.ShowDialog();
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to load detail: " + ex.Message);
//            }
//        }

//        private void ButtonNewEntry_Click(object sender, RoutedEventArgs e)
//        {
//            e.Handled = true;
//            Button AddButton = (Button)sender;
//            DataGridRow row = DataGridRow.GetRowContainingElement(AddButton);
//            DataRowView drv = (DataRowView)row.DataContext;
            
//            string login = (string)drv["loginname"];
//            if (login != null || string.IsNullOrEmpty(login)) {TimesheetEntry_OpenForm(login);}
//        }

//        private void ButtonExpandNewEmployeePanel_Click(object sender, RoutedEventArgs e)
//        {
//            this.GroupBoxNewEmployee.Visibility = Visibility.Visible;
//        }

//        private void ButtonSaveNewEmployee_Click(object sender, RoutedEventArgs e)
//        {
//            if (string.IsNullOrEmpty(this.txtboxNewEmpFirstName.Text) &&
//                string.IsNullOrEmpty(this.txtboxNewEmpLastName.Text))
//            {
//                Employee.AddNew(this.txtboxNewEmpFirstName.Text, this.txtboxNewEmpLastName.Text);
//                this.GroupBoxNewEmployee.Visibility = Visibility.Collapsed;
//            }
//            else
//            {
//                AppInfo.ShowErrorMessage("Name can't be empty", "Add New Employee");
//            }
//        }
//        #endregion
        

//        #region Functions
//        private void CreateAddNewButtonForSummaryGrid(DataGrid inGrid)
//        {
//            DataGridTemplateColumn AddCol = new DataGridTemplateColumn { CanUserReorder = false, CanUserSort = false };
//            AddCol.Header = "Action";
//            AddCol.CellTemplate = (DataTemplate)this.FindResource("NewEntryButtonDataTemplate");
//            inGrid.Columns.Insert(1, AddCol);
//        }

//        private void TimesheetEntry_OpenForm(string inLogin)
//        {
//            TimeSheetEntry win = new TimeSheetEntry(inLogin);
//            win.IsAdminMode = true;
//            win.ShowDialog();
//            win.Close();
//        }

//        private void LoadSummaryData()
//        {
//            if (this.dtpStartDate.Text == "" || this.dtpEndDate.Text == "")
//            {
//                AppInfo.ShowWarningMessage("No data selected");
//            }
//            else
//            {
//                this.dgSummary.DataContext= DATimeManagement.GetDailySummaryAll(Convert.ToDateTime(this.dtpStartDate.Text),Convert.ToDateTime(this.dtpEndDate.Text));
//            }
//        }

//        private void ButtonPrintPreviewSummary_Click(object sender, RoutedEventArgs e)
//        {
//            //DataTable dt = DATimeManagement.GetDailySummaryAll(Convert.ToDateTime(this.dtpStartDate.Text), Convert.ToDateTime(this.dtpEndDate.Text));
            
//            DataTable dt = this.dgSummary.DataContext as DataTable;
//            try
//            {
//                GenericReportViewer win = new GenericReportViewer(dt,"TimeSummaryAdmin");
//                win.Show();
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to load preview: " + ex.Message);
//            }
//        }

//        private void ButtonTestPO_Click(object sender, RoutedEventArgs e)
//        {
//            //DataTable dt = DATimeManagement.GetDailySummaryAll(Convert.ToDateTime(this.dtpStartDate.Text), Convert.ToDateTime(this.dtpEndDate.Text));

//            DataTable dt = ReportManagement.GetPurchaseOrder();
//            try
//            {
//                GenericReportViewer win = new GenericReportViewer(dt, "PurchaseOrder");
//                win.Show();
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to load preview: " + ex.Message);
//            }
//        }

//        private void CreateDeleteRoleButton(ref DataGrid inGrid)
//        {
//            DataGridTemplateColumn editButton = new DataGridTemplateColumn { CanUserReorder = false, MinWidth = 25, CanUserSort = false };
//            editButton.CellTemplate = (DataTemplate)this.FindResource("DeleteRoleButtonDataTemplate");
//            inGrid.Columns.Insert(0, editButton);
//        }

//        private void CreateApproveButtonColumn(ref DataGrid inGrid)
//        {
//            DataGridTemplateColumn approveColumn = new DataGridTemplateColumn { CanUserReorder = false, MinWidth = 50, CanUserSort = true };
//            approveColumn.Header = "Action";
//            approveColumn.CellTemplateSelector = new ApproveButtonDataTemplateSelector();
//            inGrid.Columns.Insert(0, approveColumn);
//        }

//        private void CreateApproveStatusColumn(ref DataGrid inGrid)
//        {
//            DataGridTemplateColumn approveColumn = new DataGridTemplateColumn { CanUserReorder = false, MinWidth = 50, CanUserSort = true };
//            approveColumn.Header = "Approval";
//            approveColumn.CellTemplateSelector = new ApproveStatusDataTemplateSelector();
//            inGrid.Columns.Insert(0, approveColumn);
//        }

//        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
//        {
//            e.Handled = true;
//            var item = sender as TabControl;
//            var selected = item.SelectedItem as TabItem;
//            if (selected.Name.ToString() == "EmployeeTabItem")     //load employee list
//                this.LoadEmployeeList((bool)this.CheckBoxShowAll.IsChecked);
//            else if (selected.Name.ToString() == "CustomerTabItem")
//                 AppControls.PopulateListBox(this.listCustomer, Customer.ListOfCustomer());
//            else if (selected.Name.ToString() == "TimeoffSummaryReport")
//            {
//                this.mcboEmployee.ItemsSource = null;
//                DataTable dt = Employee.ListOfEmployees(false);
//                Dictionary<string, object> emps = AppControls.ConvertTableToDictionary(dt);
//                this.mcboEmployee.ItemsSource = emps;
//            }
            
//        }

//        private void CustomerDetailTablControl_SelectionChanged(object sender, SelectionChangedEventArgs e){e.Handled=true;}

//        private void EmployeeDetailTablControl_SelectionChanged(object sender, SelectionChangedEventArgs e) { e.Handled = true; }

//        private void EmployeeList_CheckChanged(object sender, RoutedEventArgs e)
//        {
//            //load employee list
//            this.LoadEmployeeList((bool)this.CheckBoxShowAll.IsChecked);
//        }

//        private void EmployeeList_SelectionChanged(object sender, SelectionChangedEventArgs e)
//        {
//            DataRowView drv = (DataRowView)this.listEmployee.SelectedItem;
//            if (drv != null)
//            {
//                // collect info
//                string user_name = drv["efullname"].ToString();
//                this.SelectedEmployeeLogin = drv["loginname"].ToString();
//                this.SelectedEmployee_LoadData(SelectedEmployeeLogin);
//            }
//            e.Handled = true;
//        }
                       
//        private void CustomerList_SelectionChanged(object sender, SelectionChangedEventArgs e)
//        {
//            DataRowView drv = (DataRowView)this.listCustomer.SelectedItem;
//            if (drv != null)
//            {
//                // collect info
//                int customer_id = (int)drv["customerid"];
//                this.SelectedCustomer_LoadData(customer_id);
//            }
//            e.Handled = true;
//        }

//        private void SelectedEmployee_LoadData(string inLogin)
//        {   
//            using (Employee emp = new Employee(inLogin))
//            {
//                this.dgEmpRoles.Columns.Clear();
//                this.dgEmpRoles.DataContext = emp.GetRoles();
//                this.CreateDeleteRoleButton(ref this.dgEmpRoles); //add delete button to grid

//                this.txtEmpId.Text = emp.EmployeeID.ToString();
//                this.txtFirstName.Text = emp.FirstName;
//                this.txtLastName.Text = emp.LastName;
//                this.txtLogin.Text = emp.Login;
//                this.txtPassword.Text = emp.Password;
//                this.txtComment.Text = emp.Comments;
//                this.dtpDateHired.Text = emp.DateHired;
//                this.dtpDateTerminated.Text = emp.DateTerminated;
//                this.dtpFulltime.Text = emp.DateFulltime;
//                this.checkboxActive.IsChecked = emp.IsActiveEmployee;
//                this.txtJobTitle.Text = emp.JobTitle;
//                this.txtDepartment.Text = emp.Department;
                                
//                DataRow dr = Employee.GetEmpPaidTimeOff(Convert.ToDateTime(this.dtpSelectedDate.Text), (string)this.txtLogin.Text).Rows[0];
//                this.txtVacAvail.Text = dr["VacaAvailable"].ToString();
//                this.btnViewRolloverHistory.Content = dr["vacarollover"].ToString();
//                this.btnViewVacDetail.Content = dr["vacaused"].ToString();
//                this.txtVacRemain.Text = dr["VacaRemaining"].ToString();
//                this.txtSickAvail.Text = dr["sickavailable"].ToString();
//                this.txtSickRemain.Text = dr["sickremaining"].ToString();
//                this.btnViewSickDetail.Content = dr["sickused"].ToString();

//                this.dgInsurance.DataContext = Employee.GetEmpInsurance(Convert.ToDateTime(this.dtpSelectedDate.Text),(string)this.txtLogin.Text);

//            }
//        }

//        private void SelectedCustomer_LoadData(int inCustomerId)
//        {
//            if (inCustomerId > 0)
//            {
//                using (Customer cust = new Customer(inCustomerId))
//                {
//                    //load main info
//                    this.txtCustomerId.Text = Convert.ToString(cust.CustomerId);
//                    this.txtCustomerName.Text = cust.CustomerName;
//                    this.txtWeb.Text = cust.Website;

//                    //load location
//                    this.dgCustomerLocation.DataContext = cust.ListOfLocation();

//                    //load contacts 
//                }
//            }
//            else
//            {
//                //load main info
//                this.txtCustomerId.Text = string.Empty;
//                this.txtCustomerName.Text = string.Empty;
//                this.txtWeb.Text = string.Empty;

//                //load location
//                this.dgCustomerLocation.DataContext = null;
//            }

//        }

//        private void DeleteRoleButton_Click(object sender, RoutedEventArgs e)
//        {
//            if (AppInfo.ShowYesNoMessage("You are about to remove this role from the employee. Are you sure that you want to do that?")
//                == MessageBoxResult.Yes)
//            {
//                Button approveButton = (Button)sender;
//                DataGridRow selectedRow = DataGridRow.GetRowContainingElement(approveButton);
//                DataRowView drv = (DataRowView)selectedRow.DataContext;
//                int role_id = (int)drv["roleid"];
//                using (Employee emp = new Employee(this.SelectedEmployeeLogin))
//                {
//                    emp.DeleteRole(role_id);
//                    EmployeeRolesDatagrid_LoadData(emp.GetRoles());
//                }
//            }
//        }

//        private void ExpandAddRolePanel(object sender, RoutedEventArgs e)
//        {
//            if (this.AddRolePanel.Visibility != Visibility.Visible)
//            {
//                AppControls.PopulateComboBox(ref this.cboRoles, Employee.ListOfRoles());
//                this.AddRolePanel.Visibility = Visibility.Visible;
//            }
//        }
  
//        private void CommitAddingRoleButton_Click(object sender, RoutedEventArgs e)
//        {
//            try
//            {
//                using (Employee emp = new Employee(this.SelectedEmployeeLogin))
//                {
//                    int role_id = (int)this.cboRoles.SelectedValue;
//                    emp.AddRole(role_id);

//                    EmployeeRolesDatagrid_LoadData(emp.GetRoles());
//                }
//                this.AddRolePanel.Visibility = Visibility.Collapsed;
//                this.cboRoles.DataContext = null;
//            }
//            catch (Exception ex)
//            {
//                AppInfo.ShowErrorMessage("Failed to add: " + ex.Message);
//            }
//        }

//        private void EmployeeRolesDatagrid_LoadData(DataTable inDatatable)
//        {
//            this.dgEmpRoles.Columns.Clear();
//            this.dgEmpRoles.DataContext = inDatatable;
//            this.CreateDeleteRoleButton(ref this.dgEmpRoles);
//        }
        
//        public void ButtonUpdateEmployeeInfo_Click(object sender, RoutedEventArgs e)
//        {
//            if (string.IsNullOrEmpty(this.txtEmpId.Text) == false){
//                using (Employee emp = new Employee())
//                {
//                    emp.EmployeeID = Convert.ToInt16(this.txtEmpId.Text);
//                    emp.FirstName = this.txtFirstName.Text;
//                    emp.LastName = this.txtLastName.Text;
//                    emp.Login = this.txtLogin.Text;
//                    emp.Password = this.txtPassword.Text;
//                    emp.Comments = this.txtComment.Text;
//                    emp.DateHired = this.dtpDateHired.Text;
//                    emp.DateFulltime = this.dtpFulltime.Text;
//                    emp.DateTerminated = this.dtpDateTerminated.Text;
//                    emp.IsActiveEmployee = (bool)this.checkboxActive.IsChecked;
//                    emp.JobTitle = this.txtJobTitle.Text;
//                    emp.Department = this.txtDepartment.Text;
//                    emp.Update();
//                }
//            }

//        }

        
//        public void ExpandAndHideEmployeeNavigationPanel(object sender, RoutedEventArgs e)
//        {
//            if (this.EmployeeNavigationPanel.Visibility == Visibility.Visible)
//            {
//                this.EmployeeNavigationPanel.Visibility = Visibility.Collapsed;
//            }
//            else if (this.EmployeeNavigationPanel.Visibility == Visibility.Collapsed)
//            {
//                this.EmployeeNavigationPanel.Visibility = Visibility.Visible;
//            }
//        }

//        public void ExpandAndHideCustomerNavigationPanel(object sender, RoutedEventArgs e)
//        {
//            if (this.CustomerNavigationPanel.Visibility == Visibility.Visible)
//            {
//                this.CustomerNavigationPanel.Visibility = Visibility.Collapsed;
//            }
//            else if (this.CustomerNavigationPanel.Visibility == Visibility.Collapsed)
//            {
//                this.CustomerNavigationPanel.Visibility = Visibility.Visible;
//            }
//        }

//        public void ButtonAddNewCustomer_Click(object sender, RoutedEventArgs e)
//        {
//            if (this.grpboxNewCustomer.Visibility != Visibility.Visible)
//            {
//                this.grpboxNewCustomer.Visibility = Visibility.Visible;
//            }
//        }

//        public void ButtonSaveNewCustomer_Click(object sender, RoutedEventArgs e)
//        {
//            using (Customer cust = new Customer())
//            {
//                cust.CustomerName = this.txtNewCustomerName.Text;
//                cust.Website = this.txtNewCustomerWebsite.Text;
//                if (cust.Add() == true)
//                {
//                    this.grpboxNewCustomer.Visibility = Visibility.Collapsed;
//                    AppControls.PopulateListBox(this.listCustomer, Customer.ListOfCustomer());
//                    this.SelectedCustomer_LoadData(0);
//                }
//            }
//        }

//        public void ButtonSaveCustomer_Click(object sender, RoutedEventArgs e)
//        {
//            using (Customer cust = new Customer(Convert.ToInt16(this.txtCustomerId.Text)))
//            {
//                cust.CustomerName = this.txtCustomerName.Text;
//                cust.Website = this.txtWeb.Text;
//                cust.Update();
//                AppControls.PopulateListBox(this.listCustomer, Customer.ListOfCustomer());
//                this.SelectedCustomer_LoadData(0);
//            }
//        }

//        public void ButtonRemoveCustomer_Click(object sender, RoutedEventArgs e)
//        {
//            using (Customer cust = new Customer(Convert.ToInt16(this.txtCustomerId.Text)))
//            {
//                if (cust.Remove() == true)
//                {
//                    AppControls.PopulateListBox(this.listCustomer, Customer.ListOfCustomer());
//                    this.SelectedCustomer_LoadData(0);
//                }
//            }
//        }

//        public void ButtonViewTimeoffSummaryReport_Click(object sender, RoutedEventArgs e)
//        {
//            string emps = string.Empty;
//            DateTime? run_date = null;

//            Dictionary<string, object> SelectedItems;
//            SelectedItems = this.mcboEmployee.SelectedItems;

//            if (SelectedItems != null)
//                emps = string.Join(",", SelectedItems.Values);

//            if (!string.IsNullOrEmpty(this.dtpRunDate.Text))
//                run_date = Convert.ToDateTime(this.dtpRunDate.Text);

//            if (!string.IsNullOrEmpty(emps) && run_date != null)
//            {
//                string cats = "VACA,SICK,UNTO";
//                DataTable dt = TimeLog.GetReportTimeOffSummary(emps,cats,run_date);
                
//                Microsoft.Reporting.WinForms.ReportDataSource rds = new Microsoft.Reporting.WinForms.ReportDataSource("RESULTS", dt);
                
//                this._reportViewer.Reset();
//                this._reportViewer.LocalReport.DataSources.Clear();
//                this._reportViewer.LocalReport.DataSources.Add(rds);
//                this._reportViewer.LocalReport.ReportPath = @"Reports/ADMIN_REPORT_TIME_OFF_SUMMARY.rdlc";
//                this._reportViewer.LocalReport.Refresh();
//                this._reportViewer.RefreshReport();
//            }
//        }

//        private void AsOfDate_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
//        {
//            DataRowView drv = (DataRowView)this.listEmployee.SelectedItem;
//            if (drv != null)
//            {
//                // collect info
//                string user_name = drv["efullname"].ToString();
//                this.SelectedEmployeeLogin = drv["loginname"].ToString();
//                this.SelectedEmployee_LoadData(SelectedEmployeeLogin);
//            }
//            e.Handled = true;
//        }

//        public void LoadEmployeeList(bool inShowAll)
//        {
//            try
//            {
//                DataTable dt = Employee.ListOfEmployees(inShowAll);

//                // bind data
//                this.listEmployee.DataContext = dt;
//                this.listEmployee.DisplayMemberPath = dt.Columns[0].ToString();
//                this.listEmployee.SelectedValuePath = dt.Columns[1].ToString();
//            }
//            catch (Exception ex)
//            {
//               AppInfo.ShowErrorMessage("Failed to load employee list: " + ex.Message);
//            }
//        }

        
//        #endregion

     

        

                
//        #region Detail Grid Events

//        //void CancelEntry(object sender, RoutedEventArgs e)
//        //{
//        //    e.Handled = true;
//        //    Button cancelButton = (Button)sender;
//        //    DataGridRow row = DataGridRow.GetRowContainingElement(cancelButton);
//        //    row.DetailsVisibility = Visibility.Collapsed;
//        //}

        
        

//        /* commented out handle edit button for detail datagrid
//        void HandleEditButtonForDetailDataGrid(object sender, RoutedEventArgs e)
//        {
//            e.Handled = true;
//            Button EditButton = (Button)sender;
//            DataGridRow row = DataGridRow.GetRowContainingElement(EditButton);
//            DataRowView inDataRowView = (DataRowView)row.DataContext;

//            TimesheetEdit win = new TimesheetEdit(ref inDataRowView);
//            win.Owner = this;
//            win.ShowDialog();
//        }
//        */
//        #endregion      
//    }

//}
