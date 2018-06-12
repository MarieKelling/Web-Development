using System;
using System.Windows.Input;
using BISEC.Service;

namespace BISEC.ViewModel
{
    public class WorkspaceViewModel : ViewModelBase
    {
        #region Fields
        bool disposed = false;
        RelayCommand _closeCommand;
        
        #endregion // Fields

        #region Constructor

        protected WorkspaceViewModel()
        {

        }

        #endregion // Constructor
        
        #region CloseCommand

        /// <summary>
        /// Returns the command that, when invoked, attempts
        /// to remove this workspace from the user interface.
        /// </summary>
        public ICommand CloseCommand
        {
            get
            {
                if (_closeCommand == null)
                    _closeCommand = new RelayCommand(param => this.OnRequestClose());

                return _closeCommand;
            }
        }

        #endregion // CloseCommand

        #region RequestClose [event]

        /// <summary>
        /// Raised when this workspace should be removed from the UI.
        /// </summary>
        public event EventHandler RequestClose;

        public virtual void OnRequestClose()
        {
            EventHandler handler = this.RequestClose;
            if (handler != null)
                handler(this, EventArgs.Empty);
        }

        #endregion // RequestClose [event]

        #region Disposing
        protected override void OnDispose(bool disposing)
        {
            if (disposed)
                return;

            if (disposing)
            {
                // Free any other managed objects here


            }

            // Free any unmanaged objects here
            //
            disposed = true;

            // Call the base class implementation
            base.OnDispose(disposing);
        }

        #endregion // Disposing
    }
}

