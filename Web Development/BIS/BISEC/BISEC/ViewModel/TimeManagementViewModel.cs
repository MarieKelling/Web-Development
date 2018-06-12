using BISEC.Model;
using BISEC.Service;
using BISEC.View;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Data;
using System.Windows.Input;

namespace BISEC.ViewModel
{
    class TimeManagementViewModel : WorkspaceViewModel
    {
        #region Constructor
        public TimeManagementViewModel()
        {
            this.StartDT = DateTime.Now.StartOfWeek(DayOfWeek.Monday);
            this.EndDT = DateTime.Now;
        }
        #endregion //Constructor


        #region Presentation
        public ICommand PunchInCommand
        {
            get
            {
                if (_punchInCommand == null)
                    _punchInCommand = new RelayCommand(para => this.PunchIn(), para=> (this.CanPunchIn && !this.IsOnsite));
                return _punchInCommand;
            }
        }

        public ICommand PunchOutCommand
        {
            get
            {
                if (_punchOutCommand == null)
                    _punchOutCommand = new RelayCommand(para => this.PunchOut(), para=>( this.CanPunchOut && !this.IsOnsite ));
                return _punchOutCommand;
            }
        }

        public ICommand LeaveForJobSiteCommand
        {
            get
            {
                if (_goJobSiteCommand == null)
                    _goJobSiteCommand = new RelayCommand(para => this.OnsitePunch('o'), para=>(!this.IsOnsite && !this.CanPunchIn));
                return _goJobSiteCommand;
            }
        }

        public ICommand ReturnFromJobSiteCommand
        {
            get
            {
                if (_backFromJobSiteCommand == null)
                    _backFromJobSiteCommand = new RelayCommand(para => this.OnsitePunch('i'), para=>(this.IsOnsite));
                return _backFromJobSiteCommand;
            }
        }

        public ICommand EditLogCommand
        {
            get
            {
                if (_editLogCommand == null)
                    _editLogCommand = new RelayCommand(para => this.EditLog(para));
                return _editLogCommand;
            }
        }

        public ICommand AddLogCommand
        {
            get
            {
                if (_addLogCommand == null)
                    _addLogCommand = new RelayCommand(para => this.AddLog());
                return _addLogCommand;
            }
        }

        public ICommand DeleteLogCommand
        {
            get
            {
                if (_deleteLogCommand == null)
                    _deleteLogCommand = new RelayCommand(para => this.DeleteLog(para));
                return _deleteLogCommand;
            }
        }

        public DateTime StartDT
        {
            get { return _startDT; }
            set
            {
                _startDT = value;
                OnPropertyChanged("StartDT");
                OnSelectedDateChanged();
            }
        }

        public DateTime EndDT
        {
            get { return _endDT; }
            set
            {
                _endDT = value;
                OnPropertyChanged("EndDT");
                OnSelectedDateChanged();
            }
        }

        public ICollectionView PTOSummaryListView
        {
            get 
            { 
                if (_ptoSummaryListView == null)
                    _ptoSummaryListView = CollectionViewSource.GetDefaultView(
                        DataService.GetEmployeePTOSummary(App.CurrentUser.EmployeeID ?? 0));
                return _ptoSummaryListView;
            }
        }

        public ICollectionView TimesheetListView
        {
            get { return _timesheetListView; }
            set
            {
                _timesheetListView = value;
                OnPropertyChanged("TimesheetListView");
            }
        }

        #endregion //Presentation


        #region Private Helpers
        bool CanPunchIn
        {
            get
            {
                if (App.CurrentUser == null)
                    return false;
                else
                {
                    return DataService.IsClockInEnabled(App.CurrentUser.EmployeeID ?? 0);
                }
            }
        }

        bool CanPunchOut
        {
            get { return !CanPunchIn; }
        }

        bool IsOnsite
        {
            get
            {
                if (App.CurrentUser == null)
                    return false;
                else
                {
                    return DataService.IsEmployeeOnsite(App.CurrentUser.EmployeeID ?? 0);
                }
            }
        }

        internal void PunchIn()
        {
            DataService.Punch(App.CurrentUser.EmployeeID ?? 0, 'i');
            OnSelectedDateChanged();
        }

        internal void PunchOut()
        {
            DataService.Punch(App.CurrentUser.EmployeeID ?? 0, 'o');
            OnSelectedDateChanged();
        }

        internal void OnsitePunch(object para)
        {
            char inout = para.ToString()[0];
            if (inout == 'o') //leave for job site
            {
                DataService.Punch(App.CurrentUser.EmployeeID ?? 0, 'o'); // close in-shop section
                DataService.OnsitePunchIn(App.CurrentUser.EmployeeID ?? 0); // open on-site section
            }
            else
            {
                OnsiteQuickEntry win = new OnsiteQuickEntry(App.CurrentUser.EmployeeID ?? 0);
                win.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                win.ShowDialog();
            }

            OnSelectedDateChanged();
        }

        internal void AddLog()
        {
            OpenTimesheetEntryWindow(0, App.CurrentUser.EmployeeID ?? 0);
        }

        internal void EditLog(object para)
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

        internal void DeleteLog(object para)
        {
            try
            {
                string confirmMsg = "You are about to delete this record. Are you sure to do that?";
                if (PrivateHelper.ShowYesNoMessage(confirmMsg) == true)
                {
                    int logId = Convert.ToInt32((para as DataRowView)["Id"]);
                    using (TimeManagementDataContext dc = new TimeManagementDataContext())
                    {
                        bool r = dc.DeleteLogByID(logId);
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

        internal void OpenTimesheetEntryWindow(int logID, int inEmployeeID=0)
        {
            TimesheetEntryViewModel vm = new TimesheetEntryViewModel(logID, false, inEmployeeID);
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

        internal void OnSelectedDateChanged()
        {
            if (StartDT > Convert.ToDateTime("2000-1-1") && EndDT > Convert.ToDateTime("2000-1-1"))
                this.TimesheetListView = CollectionViewSource.GetDefaultView(DataService.GetEmployeeTimesheet(StartDT, EndDT, App.CurrentUser.EmployeeID ?? 0));
        }

        
        #endregion //Private helpers


        #region Fields
        RelayCommand _punchInCommand, _punchOutCommand, _goJobSiteCommand, _backFromJobSiteCommand,
            _addLogCommand, _editLogCommand, _deleteLogCommand;
        DateTime _startDT, _endDT;
        private ICollectionView _timesheetListView, _ptoSummaryListView;
        
        #endregion //Fields


    }
}
