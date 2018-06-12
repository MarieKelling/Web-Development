using BISEC.ViewModel;
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

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for AdminTimesheetView.xaml
    /// </summary>
    public partial class AdminTimesheetView : UserControl
    {
        #region // .ctor
        public AdminTimesheetView()
        {
            InitializeComponent();
            Loaded += new RoutedEventHandler(AdminTimesheetView_Loaded);
        }
        #endregion 

        #region // Event Handlers
        void AdminTimesheetView_Loaded(object sender, RoutedEventArgs e)
        {
            this.DataContext = new AdminTimesheetViewModel();
        }

        void DataGrid_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
        {
            if (e.Column.Header.ToString().ToLower()=="id" ||
                e.Column.Header.ToString().ToLower()=="statusid" ||
                e.Column.Header.ToString().ToLower() == "employee_name")
            {
                e.Column.Visibility=Visibility.Hidden;
            }
        }
        #endregion 

        #region Fields
        private AdminTimesheetViewModel _viewModel;
        #endregion //Fields
    }
}
