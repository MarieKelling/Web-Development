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
using BISEC.Service;
using System.ComponentModel;

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for Updater.xaml
    /// </summary>
    public partial class Updater : Window
    {
        public Updater()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            this.labelStatus.Content = "Updating...";

            using (updateThread = new BackgroundWorker())
            {
                updateThread.DoWork += new DoWorkEventHandler(BackgroundWorker_DoWork);
                updateThread.RunWorkerCompleted += new RunWorkerCompletedEventHandler(BackgroundWorker_Completed);
                updateThread.RunWorkerAsync();
            }
        }

        internal void BackgroundWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            FileSystemExplorerService.DirectoryCopy(Properties.Settings.Default.ONSITE_NETWORK_PATH,
                            Properties.Settings.Default.ONSITE_LOCAL_PATH, true);
        }

        internal void BackgroundWorker_Completed(object sender, RunWorkerCompletedEventArgs e)
        {
            if ((e.Cancelled == true))
            {
                this.labelStatus.Content = "Canceled!";
            }

            else if (!(e.Error == null))
            {
                this.labelStatus.Content = ("Error: " + e.Error.Message);
            }

            else
            {
                this.labelStatus.Content = "Finished!";
            }
        }

        BackgroundWorker updateThread;
    }
}
