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

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for NewReleaseSplashScreen.xaml
    /// </summary>
    public partial class NewReleaseSplashScreen : Window
    {
        public NewReleaseSplashScreen()
        {
            InitializeComponent();
        }

        private void btnOk_Click(object sender, RoutedEventArgs e)
        {
            Properties.Settings.Default.Save();
            Close();
        }
    }
}
