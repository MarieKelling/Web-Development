using BISEC.Model;
using BISEC.Service;
using BISEC.View;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Data;
using System.Windows.Input;

namespace BISEC.ViewModel
{
    public class AdminTimesheetViewModel : WorkspaceViewModel
    {
        #region Constructor
        public AdminTimesheetViewModel()
        {
            this.StartDatetime = DateTime.Now.StartOfWeek(DayOfWeek.Monday).AddDays(-7);
            this.EndDatetime = DateTime.Now;
        }
        #endregion //Constructor

        #region Presentation
        public DateTime StartDatetime
        {
            get { return _startDatetime; }
            set
            {
                _startDatetime = value;
                OnSelectedDateChanged();
                OnPropertyChanged("StartDatetime");
            }
        }

        public DateTime EndDatetime
        {
            get { return _endDatetime; }
            set
            {
                _endDatetime = value;
                OnSelectedDateChanged();
                OnPropertyChanged("EndDatetime");
            }
        }

        public ICollectionView TimesheetListView
        {
            get { return _timesheetListView; }
            set
            {
                _timesheetListView = value;
                _timesheetListView.GroupDescriptions.Add(new PropertyGroupDescription("Employee_Name"));
                OnPropertyChanged("TimesheetListView");
            }
        }

        public ICommand PrintCommand 
        {
            get 
            {
                if (_printCommand == null)
                    _printCommand = new RelayCommand(para=>this.Print());
                return _printCommand;
            }
        }
        
        public ICommand AddEntryCommand 
        {
            get 
            {
                if (_addEntryCommand == null)
                    _addEntryCommand = new RelayCommand(para=>this.AddEntry());
                return _addEntryCommand;
            }
        }

        public ICommand EditEntryCommand 
        {
            get 
            {
                if (_editEntryCommand == null)
                    _editEntryCommand = new RelayCommand(para=>this.EditEntry(para));
                return _editEntryCommand;
            }
        }

        public ICommand DeleteEntryCommand
        {
            get
            {
                if (_deleteEntryCommand == null)
                    _deleteEntryCommand = new RelayCommand(para => this.DeleteEntry(para));
                return _deleteEntryCommand;
            }
        }

        public ICommand ExpandToggleCommand
        {
            get
            {
                if (_expandToggleCommand == null)
                    _expandToggleCommand = new RelayCommand(para => this.SetExpand());
                return _expandToggleCommand;
            }
        }

        public bool Expanded
        {
            get { return _expanded; }
            set
            {
                _expanded = value;
                OnPropertyChanged("Expanded");
            }
        }

        
        #endregion //Presenation

        #region Private Helpers
        void SetExpand()
        {
            this.Expanded = !this.Expanded;
        }

        void OnSelectedDateChanged()
        {
            if (StartDatetime > Convert.ToDateTime("2000-1-1") && EndDatetime > Convert.ToDateTime("2000-1-1"))
                this.TimesheetListView = CollectionViewSource.GetDefaultView(DataService.GetAdminTimesheetSummary(StartDatetime, EndDatetime));
        }

        void Print()
        {
            DataSet report_data = DataService.ReportData_AdminTimesheetSummary(StartDatetime, EndDatetime);
            Hashtable report_para = new Hashtable(){{"dStart",StartDatetime.ToShortDateString()},
                                                        {"dEnd", EndDatetime.ToShortDateString()}};
            
            ReportView win = new ReportView(ReportName.AdminTimesheetSummary, ref report_data, ref report_para);
           
            win.Show();
        }

        void AddEntry()
        {
            MultiTimesheetInsertViewModel vm = new MultiTimesheetInsertViewModel();
            MultiTimesheetView win = new MultiTimesheetView();

            // when the viewmodel asks to be closed, close the window.
            System.EventHandler handler = null;
            handler = delegate
            {
                vm.RequestClose -= handler;
                win.Close();
            };
            vm.RequestClose += handler;

            win.DataContext = vm;
            win.ShowDialog();

            OnSelectedDateChanged();
        }

        void EditEntry(object para)
        {
            try
            {
                int logId = Convert.ToInt32((para as DataRowView)["Id"]);
                OpenTimesheetEntryWindow(logId);
            }
            catch (Exception ex)
            {
                PrivateHelper.ShowErrorMessage(ex.Message);
            }
        }

        void DeleteEntry(object para)
        {
            try
            {
                string confirmMsg = "You are about to delete this record. Are you sure to do that?";
                if (PrivateHelper.ShowYesNoMessage(confirmMsg) == true)
                {
                    int logId = Convert.ToInt32((para as DataRowView)["Id"]);
                    using (TimeManagementDataContext dc = new TimeManagementDataContext())
                    {
                        bool r = dc.DeleteLogByID(logId, true);
                        if (r == false)
                            PrivateHelper.ShowErrorMessage("Failed to delete this record.");
                    }
                    OnSelectedDateChanged();
                }
            }
            catch (Exception ex)
            {
                PrivateHelper.ShowErrorMessage(ex.Message);
            }
        }

        internal void OpenTimesheetEntryWindow(int logID, int inEmployeeID = 0)
        {
            TimesheetEntryViewModel vm = new TimesheetEntryViewModel(logID, true, inEmployeeID);
            TimesheetEntry win = new TimesheetEntry();

            // when the viewmodel asks to be closed, close the window.
            System.EventHandler handler = null;
            handler = delegate
            {
                vm.RequestClose -= handler;
                win.Close();
            };
            vm.RequestClose += handler;

            win.DataContext = vm;
            win.ShowDialog();

            OnSelectedDateChanged();
        }
        #endregion //Private helpers

        #region Fields
        private DateTime _startDatetime, _endDatetime;
        private ICollectionView _timesheetListView;
        private RelayCommand _printCommand, _addEntryCommand, _editEntryCommand, _deleteEntryCommand, _expandToggleCommand;
        private bool _expanded = false;
        #endregion //Fields
    }
}
