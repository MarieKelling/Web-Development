using BISEC.Model;
using BISEC.Service;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;
using System.Windows.Input;

namespace BISEC.ViewModel
{
    class MultiTimesheetInsertViewModel : WorkspaceViewModel
    {
        #region Constructor
        public MultiTimesheetInsertViewModel()
        {
            
            InitializeComponent();
            HeaderMessage = "Timesheet Insert";
        }
        #endregion //Constructor

        #region Presentation
        public string HeaderMessage { get; set; }

        public ICollectionView CarList { get; set; }
        public ICollectionView ActivityList { get; set; }
        public ICollectionView ClientLocationList { get; set; }

        public IDictionary<string, object> Employees
        {
            get
            {
                if (_employees == null)
                    _employees = PrivateHelper.ConvertEmployeeListToDictionary(
                                            BISCoreControl.Helper.GetEmployeeList(true));
                return _employees;
            }
        }

        public IDictionary<string, object> CoEmployees
        {
            get
            {
                if (_coEmployees == null)
                    _coEmployees = PrivateHelper.ConvertEmployeeListToDictionary(
                                            BISCoreControl.Helper.GetEmployeeList(true));
                return _coEmployees;
            }
        }

        public IDictionary<string, object> SelectedCoEmployees { get; set; }
        public IDictionary<string, object> SelectedEmployees { get; set; }
        
        public string SelectedActivityCode
        {
            get { return MyLog.activity_code; }
            set
            {
                MyLog.activity_code = value;
                OnActivitySelectionChanged();
            }
        }

        public ICommand ExitCommand
        {
            get
            {
                if (_exitCommand == null)
                    _exitCommand = new RelayCommand(para => this.Exit());
                return _exitCommand;
            }
        }

        public ICommand SaveCommand
        {
            get
            {
                if (_saveCommand == null)
                    _saveCommand = new RelayCommand(para => this.Submit());
                return _saveCommand;
            }
        }

        public Activity_Log MyLog { get; set; }
        public bool OnsiteSectionVisibility
        {
            get
            {
                if (MyLog.activity_code == "OSRG" || MyLog.activity_code == "DELI")
                    return true;
                else
                    return false;
            }
        }

        public bool AllowDateTimeUpdateSwitch
        {
            get
            {
                return _isAdmin || (MyLog.activity_code != "ISRG");
            }
        }

        public bool AllowMultiDayEntrySwitch
        {
            get
            {
                return MyLog.log_id <= 0;
            }
        }

        public bool MultiDayEntrySwitch { get; set; }

        public string StartTime
        {
            get
            {
                if (MyLog.start_time == null)
                    MyLog.start_time = Dummy_DateTime;
                return ((DateTime)MyLog.start_time).ToShortTimeString();
            }
            set
            {
                string newDT = MyLog.activity_date.ToShortDateString() + " " + value;
                try
                {
                    MyLog.start_time = Convert.ToDateTime(newDT);
                    OnPropertyChanged("StartTime");
                }
                catch (Exception ex)
                {
                    PrivateHelper.ShowErrorMessage(ex.Message + newDT);
                }
            }
        }

        public string EndTime
        {
            get
            {
                if (MyLog.end_time == null)
                    MyLog.end_time = Dummy_DateTime;
                return ((DateTime)MyLog.end_time).ToShortTimeString();
            }
            set
            {
                string newDT = MyLog.activity_date.ToShortDateString() + " " + value;
                try
                {
                    MyLog.end_time = Convert.ToDateTime(newDT);
                    OnPropertyChanged("EndTime");
                }
                catch (Exception ex)
                {
                    PrivateHelper.ShowErrorMessage(ex.Message + newDT);
                }
            }
        }

        public DateTime DateRange_End { get; set; }
        
        #endregion //Presentation


        #region Private helpers
        private TimeManagementDataContext ComponentDataContext { get; set; }
        
        void InitializeComponent()
        {
            ComponentDataContext = new TimeManagementDataContext();

            CarList = new CollectionView(ComponentDataContext.GetDropdownCar());
            ActivityList = new CollectionView(ComponentDataContext.GetDropdownActivity());
            ClientLocationList = new CollectionView(ComponentDataContext.GetDropdownClientLocation());

            // create a temp log to hold values
            MyLog = Activity_Log.CreateNew();

            // create empty list
            SelectedEmployees = new Dictionary<string, object>();
            SelectedCoEmployees = new Dictionary<string, object>();

            DateRange_End = System.DateTime.Today; // to refresh data
        }

        void OnActivitySelectionChanged()
        {
            if (MyLog.activity_code == "ISRG" && _isAdmin == false)
            {
                MyLog.start_time = null;
                MyLog.end_time = null;
                OnPropertyChanged("StartTime");
                OnPropertyChanged("EndTime");
            }

            if (MyLog.activity_code == "OSRG")
                MyLog.LunchBreakMinutes = 30;

            OnPropertyChanged("OnsiteSectionVisibility");
            OnPropertyChanged("AllowDateTimeUpdateSwitch");
        }

        

        internal void Exit()
        {
            OnRequestClose();
        }

        internal void Submit()
        {
            try
            {
                // check if data is valid
                foreach (KeyValuePair<string, object> entry in SelectedEmployees)
                {
                    Activity_Log activity_log = Activity_Log.CreateCopy(MyLog);
                    activity_log.employee_id = Convert.ToInt32(entry.Value.ToString());

                    Insert(activity_log, entry.Key.ToString());
                }
                

                // save then exit;
                this.Exit();
            }
            catch (Exception ex)
            {
                PrivateHelper.ShowErrorMessage(ex.Message);
            }
            
        }

        internal void Insert(Activity_Log oLog, string sEmpName)
        {
            try
            {
                MyLog.start_time = Convert.ToDateTime(oLog.activity_date.ToShortDateString() + " " + StartTime);
                MyLog.end_time = Convert.ToDateTime(oLog.activity_date.ToShortDateString() + " " + EndTime);

                // check if data is valid
                if (IsValid(oLog.employee_id, sEmpName))
                {
                    string strSelectedEmployees = "";

                    if (SelectedEmployees != null)
                        strSelectedEmployees = string.Join(",", SelectedEmployees.Values);

                    oLog.OnsiteCoEmployees = strSelectedEmployees;

                    //if ((MyLog.activity_code == "VACA") || (MyLog.activity_code == "SICK"))
                    //    MyLog.log_status = -1;

                    DateTime dtStartRange = oLog.activity_date;
                    DateTime dtEndRange = oLog.activity_date;

                    if (MultiDayEntrySwitch)
                    {
                        // validate end date

                        if (DateRange_End < oLog.activity_date)
                        { throw new Exception("End Date Range cannot be older than Start Date Range"); }

                        dtEndRange = DateRange_End;
                    }

                    while (dtStartRange <= dtEndRange)
                    {
                        oLog.activity_date = dtStartRange;
                        oLog.start_time = Convert.ToDateTime(oLog.activity_date.ToShortDateString() + " " + StartTime);
                        oLog.end_time = Convert.ToDateTime(oLog.activity_date.ToShortDateString() + " " + EndTime);

                        bool addConfirm = true;

                        if (dtStartRange.DayOfWeek == DayOfWeek.Saturday ||
                            dtStartRange.DayOfWeek == DayOfWeek.Sunday)
                        {
                            string cMsg = dtStartRange.ToShortDateString() + " is a weekend. Do you still want to schedule it?";
                            if (PrivateHelper.ShowYesNoMessage(cMsg) == false)
                                addConfirm = false;
                        }

                        if (addConfirm)
                            ComponentDataContext.Activity_Logs.InsertOnSubmit(Activity_Log.CreateCopy(oLog));

                        dtStartRange = dtStartRange.AddDays(1);
                    }
                }

                ComponentDataContext.SubmitChanges();

            }
            catch (Exception ex)
            {
                PrivateHelper.ShowErrorMessage(ex.Message);
            }

        }
        #endregion //Private helpers
        
        
        #region Validation
        internal bool IsValid(int iEmployeeID, string sEmployeeName)
        {
            bool r = false;
            if (MyLog.activity_code == "DELI")
                r = true; // not validating delivery at the moment.
            else if (MyLog.start_time >= MyLog.end_time)
                PrivateHelper.ShowErrorMessage("Start time cannot be older than end time.");
            else if (ComponentDataContext.IsInputTimeConflict(MyLog.log_id, iEmployeeID, MyLog.start_time, MyLog.end_time))
                PrivateHelper.ShowErrorMessage("Selected Date and Time for [" + sEmployeeName + "] conflicts with the scheduled date and time. Please check your schedule.");
            else
                r = true;
            
            return r;
        }

        #endregion //Validation


        #region Disposing
        protected override void OnDispose(bool disposing)
        {
            if (disposed)
                return;

            if (disposing)
            {
                // Free any other managed objects here
                if (ComponentDataContext != null)
                    ComponentDataContext.Dispose();
            }

            // Free any unmanaged objects here
            //
            disposed = true;

            // Call the base class implementation
            base.OnDispose(disposing);
        }

        #endregion // Disposing


        #region Closing
        public override void OnRequestClose()
        {
            OnDispose(true);
            base.OnRequestClose();
        }
        #endregion //Closing


        #region Fields
        Dictionary<string, object> _coEmployees, _employees;
        
        bool disposed = false;
        private int _employeeID;
        private int _logID;
        RelayCommand _exitCommand, _saveCommand;
        readonly bool _isAdmin;
        private IDictionary<string, object> _selectedEmployees;
        private DateTime Dummy_DateTime = Convert.ToDateTime("2000-01-01 12:00AM");
        #endregion //Fields
    }
}
