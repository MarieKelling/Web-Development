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
    /// Interaction logic for WebBrowserView.xaml
    /// </summary>
    public partial class WebBrowserView : Window
    {
        public WebBrowserView()
        {
            InitializeComponent();

            string url = @"http://bisserver/svr08rpts/Pages/Folder.aspx";
            wbrowser.Navigate(url);
        }
    }
}
