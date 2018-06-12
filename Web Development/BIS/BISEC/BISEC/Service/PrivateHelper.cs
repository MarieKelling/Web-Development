using BISCoreControl.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace BISEC.Service
{
    public class PrivateHelper
    {
        #region Combobox loading
        public static void PopulateComboBox(ref ComboBox parComboBox, DataTable parDatatable)
        {
            parComboBox.DataContext = parDatatable.DefaultView;
            parComboBox.DisplayMemberPath = parDatatable.Columns[0].ToString();
            parComboBox.SelectedValuePath = parDatatable.Columns[1].ToString();
            //parComboBox.ItemsSource = ConvertTableToDictionary(parDatatable);
        }
        #endregion //Combobox loading

        #region Message Communication
        public static void ShowErrorMessage(string msg, string inTitle = "")
        {
            string title = BISEC.Properties.Resources.APP_NAME + ": " + inTitle;
            MessageBox.Show(msg, title, MessageBoxButton.OK, MessageBoxImage.Error);
        }

        public static void ShowWarningMessage(string msg, string inTitle = "")
        {
            string title = BISEC.Properties.Resources.APP_NAME + ": " + inTitle;
            MessageBox.Show(msg, title, MessageBoxButton.OK, MessageBoxImage.Exclamation);
        }

        public static bool ShowYesNoMessage(string msg, string inTitle = "")
        {
            string title = BISEC.Properties.Resources.APP_NAME + ": " + inTitle;
            if (MessageBox.Show(msg, title, MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                return true;
            else 
            return false;
        }

        public static void ShowInfoMessage(string msg, string inTitle = "")
        {
            string title = BISEC.Properties.Resources.APP_NAME + ": " + inTitle;
            MessageBox.Show(msg, title, MessageBoxButton.OK, MessageBoxImage.Information);
        }

        #endregion //Message


        #region Data
        public static int GetMissingPaymentOptionCount(bool bShowActiveOnly)
        {
            return BISEC.Service.DataService.GetMissingPaymentOptionCount(bShowActiveOnly);
        }

        public static DataSet GetMissingPaymentOptionDetail(bool bShowActiveOnly)
        {
            return BISEC.Service.DataService.GetMissingPaymentOptionDetail(bShowActiveOnly);
        }

        /// <summary>
        /// Count number of equipment by employee
        /// </summary>
        /// <param name="sEmpName"></param>
        /// <returns></returns>
        public static int GetEmployeeEquipmentCount(string sEmpName)
        {
            return BISEC.Service.DataService.GetEmployeeEQCount(sEmpName);
        }


        public static DataTable GetJobsWithMissingPaymentOption()
        {
            string query_name = "APP_BISEC_MISSING_PAYMENT_DETAIL";
            
            DataTable dt = new DataTable();
            BISEC.Service.DataService.LoadDataFromEQMANonVALLEYVIEW(query_name, ref dt);

            return dt;
        }

        public static DataTable GetEmployeeEquipment(string sEmployeeName)
        {
            return BISEC.Service.DataService.LoadEmployeeEquipment(sEmployeeName);
        }

        public static DataTable GetEquipmentNote(int iRelatedEquipmentID)
        {
            return BISEC.Service.DataService.LoadEquipmentNote(iRelatedEquipmentID);
        }


        public static int GetOpenRepairCount()
        {
            return BISEC.Service.DataService.GetOpenRepairCount();
        }

        public static DataSet GetOpenRepair()
        {
            return BISEC.Service.DataService.LoadOpenRepair();
        }
        #endregion //Data


        #region File/Dir Operation
        public static void OpenFile(string sFilePath)
        {
            try
            {
                System.Diagnostics.Process.Start(sFilePath);
            }
            catch (Exception ex)
            {
               ShowErrorMessage(ex.Message);
            }
        }
        #endregion //File/Dir Operation


        #region DataTable to Dictionary
        public static Dictionary<string, object> ConvertEmployeeListToDictionary(List<EMPLOYEE> oList)
        {
            try
            {
                return oList.ToDictionary(x => x.FullName, x => (object)x.EmployeeID);
            }
            catch (Exception ex)
            {
                ShowErrorMessage(ex.Message);
                return null;
            }
        }

        public static Dictionary<string, object> ConvertTableToDictionary(DataTable inDataTable)
        {
            try
            {
                return inDataTable.AsEnumerable().ToDictionary<DataRow, string, object>(row => row.Field<string>(0),
                                                                            row => row.Field<object>(1));
            }
            catch (Exception ex)
            {
                ShowErrorMessage(ex.Message);
                return null;
            }
        }
        #endregion //DataTable to Dictionary


        #region Report helper
        public static string GetReportPath(ReportName inName)
        {
            string report_root = @"Resource/Report/";
            string result = string.Empty;

            switch (inName)
            {
                case ReportName.AdminTimesheetSummary:
                    result = report_root + "AdminTimesheetSummary.rdlc";
                    break;
                case ReportName.OpenRepair:
                    result = report_root + "OpenRepair.rdlc";
                    break;
                case ReportName.MissingPaymentOption:
                    result = report_root + "MissingPayment.rdlc";
                    break;
            }

            return result;
        }

        #endregion //Report helper


        #region Onsite Updater


        #endregion //Onsite updater
    }
}
