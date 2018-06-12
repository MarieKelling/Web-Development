using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BISEC.Model;
using BISEC.ViewModel;
using System.Windows.Input;
using BISEC.Properties;
using BISEC.Service;
using System.IO;

namespace BISEC.ViewModel
{
    public class ExplorerWindowViewModel : ViewModelBase
    {
        #region // Private Members
        private DirInfo _currentDirectory;
        private DirectoryViewerViewModel _dirViewerVM;
        private IList<DirInfo> _currentItems;
        private ICommand _returnHomeCommand, _upLevelCommand, _changeViewCommand;
        private bool _showListStyle = true, _showTileStyle=false;
        #endregion

        #region // .ctor
        public ExplorerWindowViewModel(string sRootDirectory = "")
        {
            RootDirectory = sRootDirectory;
            CurrentDirectory = new DirInfo(new DirectoryInfo(RootDirectory));

            DirViewVM = new DirectoryViewerViewModel(this);
            
        }
        #endregion

        #region // Public Properties
        public bool ShowListStyle
        {
            get { return _showListStyle; }
            set 
            {   
                _showListStyle = value;
                OnPropertyChanged("ShowListStyle");
            }
        }

        public bool ShowTileStyle
        {
            get { return _showTileStyle; }
            set { 
                _showTileStyle = value;
                OnPropertyChanged("ShowTileStyle");
            }
        }

        public string RootDirectory { get; set; }

        /// <summary>
        /// Name of the current directory user is in
        /// </summary>
        public DirInfo CurrentDirectory
        {
            get { return _currentDirectory; }
            set
            {
                _currentDirectory = value;
                RefreshCurrentItems();
                OnPropertyChanged("CurrentDirectory");
            }
        }

        public DirectoryViewerViewModel DirViewVM
        {
            get { return _dirViewerVM; }
            set
            {
                _dirViewerVM = value;
                OnPropertyChanged("DirViewVM");
            }
        }

        public IList<DirInfo> CurrentItems
        {
            get
            {
                if (_currentItems == null)
                {
                    _currentItems = new List<DirInfo>();
                }
                return _currentItems;
            }
            set
            {
                _currentItems = value;
                OnPropertyChanged("CurrentItems");
            }
        }

        public ICommand ReturnHomeCommand
        {
            get
            {
                if (_returnHomeCommand == null)
                    _returnHomeCommand = new RelayCommand(param => this.ReturnHome());
                return _returnHomeCommand;
            }
        }

        public ICommand UpLevelCommand
        {
            get
            {
                if (_upLevelCommand == null)
                    _upLevelCommand = new RelayCommand(param => this.UpLevel());
                return _upLevelCommand;
            }
        }

        public ICommand ChangeViewCommand
        {
            get
            {
                if (_changeViewCommand == null)
                    _changeViewCommand = new RelayCommand(param => this.ChangeListViewStyle());
                return _changeViewCommand;
            }
        }
        #endregion

        #region // methods
        protected void ChangeListViewStyle()
        {
            this.ShowListStyle = !this.ShowTileStyle;
            this.ShowTileStyle = !this.ShowListStyle;
        }

        protected void ReturnHome()
        {
            CurrentDirectory.Path = RootDirectory;
            RefreshCurrentItems();
            OnPropertyChanged("CurrentDirectory");
        }

        protected void UpLevel()
        {
            if (CurrentDirectory.Path != RootDirectory)
            {
                DirectoryInfo parents = FileSystemExplorerService.GetParent(CurrentDirectory.Path);
                CurrentDirectory.Path = parents.FullName;
                RefreshCurrentItems();
                OnPropertyChanged("CurrentDirectory");
            }
        }


        /// <summary>
        /// this method gets the children of current directory and stores them in the CurrentItems Observable collection
        /// </summary>
        protected void RefreshCurrentItems()
        {
            IList<DirInfo> childDirList = new List<DirInfo>();
            IList<DirInfo> childFileList = new List<DirInfo>();

            //If current directory is "My computer" then get the all logical drives in the system
            //if (CurrentDirectory.Name.Equals(this.RootDirectory))
            //{
            //    childDirList = (from rd in FileSystemExplorerService.GetRootDirectories()
            //                    select new DirInfo(rd)).ToList();
            //}
            //else
            //{
                //Combine all the subdirectories and files of the current directory
                childDirList = (from dir in FileSystemExplorerService.GetChildDirectories(CurrentDirectory.Path)
                                select new DirInfo(dir)).ToList();

                childFileList = (from fobj in FileSystemExplorerService.GetChildFiles(CurrentDirectory.Path)
                                 select new DirInfo(fobj)).ToList();

                childDirList = childDirList.Concat(childFileList).ToList();
            //}

            CurrentItems = childDirList;
        }
        #endregion
    }
}