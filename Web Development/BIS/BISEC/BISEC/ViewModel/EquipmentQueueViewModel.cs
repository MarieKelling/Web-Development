using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BISEC.Service;
using System.Windows.Data;
using System.Data;
using System.Windows.Input;


namespace BISEC.ViewModel
{
    class EquipmentQueueViewModel : WorkspaceViewModel
    {
        #region Constructor
        public EquipmentQueueViewModel()
        {
            InitializeObject();
        }
        #endregion //Constructor


        #region Presentation
        public string NewNote { get; set; }

        public ICollectionView EqupimentListView
        {
            get {return CollectionViewSource.GetDefaultView(_equipmentItems);}
            
        }

        public DataTable EQItems
        {
            get { return _equipmentItems; }
        }

        public DataRowView CurrentEQItem
        {
            get { return _currentEQItem; }
            set
            {
                _currentEQItem = value;
                OnEQItemSelectionChanged();
            }
        }

        public bool NewNoteVisibility
        {
            get { return _currentEQItem != null; }
        }

        public DataTable NoteItems
        {
            get { return _noteItems; }
            set
            {
                _noteItems = value;
                OnPropertyChanged("NoteItems");
                OnPropertyChanged("NewNoteVisibility");
            }
        }

        public ICommand PrintCommand
        {
            get
            {
                if (_printCommand == null)
                    _printCommand = new RelayCommand(para => this.Print());
                return _printCommand;
            }
        }

        public ICommand UpdateJobCommand
        {
            get
            {
                if (_updateJobCommand == null)
                    _updateJobCommand = new RelayCommand(para => this.UpdateJob());
                return _updateJobCommand;
            }
        }

        public ICommand AddNoteCommand
        {
            get
            {
                if (_addNoteCommand == null)
                    _addNoteCommand = new RelayCommand(para => this.AddNote());
                return _addNoteCommand;
            }
        }

        public bool ShowStatusLabelSwitch 
        {   
            get { return _showStatusLabelSw;}

            set
            {
                _showStatusLabelSw = value;
                OnPropertyChanged("ShowStatusLabelSwitch");
                OnPropertyChanged("ShowGridSwitch");
            } 
        }

        public bool ShowGridSwitch { get { return !_showStatusLabelSw; } }
        #endregion //Presenation


        #region Private helper

        BackgroundWorker loadDataThread;
        
        internal void InitializeObject()
        {
            LoadData();
        }

        internal void Print()
        {
            PrivateHelper.ShowInfoMessage("Coming soon");
        }

        internal void UpdateJob()
        {
            PrivateHelper.ShowInfoMessage("Coming soon");
        }

        internal void LoadData()
        {
            this.ShowStatusLabelSwitch = true;

            using (loadDataThread = new BackgroundWorker())
            {
                loadDataThread.DoWork += new DoWorkEventHandler(BackgroundWorker_DoWork);
                loadDataThread.RunWorkerCompleted += new RunWorkerCompletedEventHandler(BackgroundWorker_Completed);
                loadDataThread.RunWorkerAsync();
            }
        }

        internal void BackgroundWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            _equipmentItems = PrivateHelper.GetEmployeeEquipment(App.CurrentUser.FullName);
        }

        internal void BackgroundWorker_Completed(object sender, RunWorkerCompletedEventArgs e)
        {
            this.ShowStatusLabelSwitch = false;
            OnPropertyChanged("EQItems");
        }

        internal void OnEQItemSelectionChanged()
        {
            // load note
            NoteItems = PrivateHelper.GetEquipmentNote(Convert.ToInt32(CurrentEQItem["Id"]));
        }

        internal void AddNote()
        {
            int relatedEQId = 0;
            bool b = false;

            Int32.TryParse(CurrentEQItem["Id"].ToString(), out relatedEQId);

            if (relatedEQId > 0)
                b = DataService.AddEquipmentNote(relatedEQId, this.NewNote, App.CurrentUser.FullName);
            
            if (b)
            {
                this.NewNote = String.Empty;
                OnPropertyChanged("NewNote");
                OnEQItemSelectionChanged();
            }   
        }
        #endregion //Private helper


        #region Fields
        RelayCommand _printCommand, _addNoteCommand, _updateJobCommand;
        //readonly BISWorkDataContext _mainDataContext;
        private EquipmentListType _listType;
        private bool _showStatusLabelSw;
        private DataTable _equipmentItems, _noteItems;
        private DataRowView _currentEQItem;
        #endregion //Fields
    }
}
