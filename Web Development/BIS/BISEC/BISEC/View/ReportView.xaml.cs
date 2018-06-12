using BISEC.Service;
using Microsoft.Reporting.WinForms;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
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
using System.Web;

namespace BISEC.View
{
    /// <summary>
    /// Interaction logic for ReportView.xaml
    /// </summary>
    public partial class ReportView : Window
    {
        #region .ctr

        public ReportView()
        {
            InitializeComponent();
        }

        public ReportView(ReportName inReportName, ref DataSet inData, ref Hashtable inPara)
            : this()
        {
            _reportName = inReportName;
            _reportData = inData;
            _reportParameter = inPara;
        }

        public ReportView(ReportName inReportName, ref DataSet inData)
            : this()
        {
            _reportName = inReportName;
            _reportData = inData;
        }

        
        #endregion //ctr

        #region events
        private void ReportView_Load(object sender, EventArgs e)
        {
            this.reportViewer.ProcessingMode = Microsoft.Reporting.WinForms.ProcessingMode.Local;
            this.reportViewer.Reset();

            // assign report path
            Microsoft.Reporting.WinForms.LocalReport locReport = this.reportViewer.LocalReport;
            locReport.ReportPath = PrivateHelper.GetReportPath(_reportName);
                      
            // assign data
            foreach (DataTable dt in _reportData.Tables)
            {
                try
                {
                    locReport.DataSources.Add(new ReportDataSource(dt.TableName, dt));
                }
                catch(Exception ex)
                {
                    PrivateHelper.ShowErrorMessage("Failed to load data: " + ex.Message);
                }
            }

            // assign parameter if any
            if (_reportParameter != null)
            {
                if (_reportParameter.Count > 0)
                {
                    ReportParameter[] paras = new ReportParameter[_reportParameter.Count];
                    int iLoop = 0;

                    foreach (DictionaryEntry pair in _reportParameter)
                    {
                        paras[iLoop] = new ReportParameter(pair.Key.ToString(), pair.Value.ToString());

                        iLoop += 1;
                    }

                    try
                    {
                        locReport.SetParameters(paras);
                    }
                    catch (Exception ex)
                    {
                        PrivateHelper.ShowErrorMessage(ex.Message);
                    }
                }
            }

            // refresh report
            this.reportViewer.RefreshReport();
        }

        #endregion //events

        #region helpers
        

        #endregion //helpers

        #region Fields
        ReportName _reportName;
        DataSet _reportData;
        Hashtable _reportParameter;
        #endregion //Fields


        // Export to excel
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Warning[] warnings;
            string[] streamids;
            string mimeType;
            string encoding;
            string extension;
            string filename;

            byte[] bytes = this.reportViewer.LocalReport.Render(
               "Excel", null, out mimeType, out encoding,
                out extension,
               out streamids, out warnings);

            filename = string.Format("{0}.{1}", "ExportToExcel", "xls");
            HttpContext.Current.Response.ClearHeaders();
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=" + filename);
            HttpContext.Current.Response.ContentType = mimeType;
            HttpContext.Current.Response.BinaryWrite(bytes);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
    }
}
