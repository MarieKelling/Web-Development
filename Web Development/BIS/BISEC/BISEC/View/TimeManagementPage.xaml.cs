using BISEC.ViewModel;
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

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for TimeManagementPage.xaml
    /// </summary>
    public partial class TimeManagementPage : Page
    {

        public TimeManagementPage()
        {
            InitializeComponent();

           this._dataContext= new TimeManagementViewModel();
           this.DataContext = this._dataContext;
        }

        void TimeManagementPage_Unloaded(object sender, RoutedEventArgs e )
        {
            if (_dataContext != null)
                _dataContext.Dispose();
        }

        private TimeManagementViewModel _dataContext;

        private void dgTimesheet_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
        {
            if (e.Column.Header.ToString().ToLower() == "id")
            {
                e.Column.Visibility = Visibility.Hidden;
            }
        }
    }

    
}
