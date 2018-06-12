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
    /// Interaction logic for EquipmentListPage.xaml
    /// </summary>
    public partial class EquipmentListPage : Page
    {
        public EquipmentListPage()
        {
            InitializeComponent();
        }

        private void dg_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
        {
            if (e.Column.Header.ToString().ToLower() == "id")
            {
                e.Column.Visibility = Visibility.Hidden;
            }
        }
    }
}
