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
using BISEC.View;
using System.Collections;


namespace BISEC.ViewModel
{
    class EquipmentListViewModel : WorkspaceViewModel
    {
        #region Constructor
        public EquipmentListViewModel(EquipmentListType eType, bool bShowActiveOnly)
        {
            _listType = eType;
            _showActiveOnly = bShowActiveOnly;
            InitializeObject();
        }
        #endregion //Constructor


        #region Presentation
        public ICollectionView ItemListView
        {
            get {return CollectionViewSource.GetDefaultView(_itemList);}
            
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
            switch (_listType)
            {
                case EquipmentListType.MissingPaymentOption:
                    base.DisplayName = "Jobs Missing Payment Option";
                    break;
                case EquipmentListType.OpenRepair:
                    base.DisplayName = "OPEN REPAIR";
                    break;

            }
            LoadData();
        }

        internal void Print()
        {
            ReportView win;

            switch(_listType)
            {
                case EquipmentListType.OpenRepair:
                    win = new ReportView(ReportName.OpenRepair, ref _dsItem);
                    win.Show();
                    break;

                case EquipmentListType.MissingPaymentOption:
                    Hashtable report_para = new Hashtable() { { "showActiveOnly", _showActiveOnly } };
                    win = new ReportView(ReportName.MissingPaymentOption, ref _dsItem, ref report_para);
                    win.Show();
                    break;

                default:
                    PrivateHelper.ShowInfoMessage("Coming soon");
                    break;
            }
            
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
            switch (_listType)
            {
                case EquipmentListType.MissingPaymentOption:
                    _dsItem = PrivateHelper.GetMissingPaymentOptionDetail(_showActiveOnly);
                    _itemList = _dsItem.Tables[0];
                    break;
                case EquipmentListType.OpenRepair:
                    _dsItem = PrivateHelper.GetOpenRepair(); //this step is to prepare for printable report
                    _itemList = _dsItem.Tables[0];
                    break;
            }
        }

        internal void BackgroundWorker_Completed(object sender, RunWorkerCompletedEventArgs e)
        {
            this.ShowStatusLabelSwitch = false;
            OnPropertyChanged("ItemListView");
        }
        #endregion //Private helper


        #region Fields
        RelayCommand _printCommand, _addNoteCommand, _updateJobCommand;
        //readonly BISWorkDataContext _mainDataContext;
        private EquipmentListType _listType;
        private bool _showStatusLabelSw;
        private DataTable _itemList;
        private DataSet _dsItem;
        private bool _showActiveOnly;
        #endregion //Fields
    }
}
