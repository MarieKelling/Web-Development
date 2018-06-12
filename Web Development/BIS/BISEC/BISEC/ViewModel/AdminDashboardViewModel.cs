using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BISEC.ViewModel
{
    public class AdminDashboardViewModel
    {
        #region Presentation
        public AdminTimesheetViewModel AdminTimesheetVM
        {
            get
            {
                if (_adminTimesheetViewModel == null)
                    _adminTimesheetViewModel = new AdminTimesheetViewModel();
                return _adminTimesheetViewModel;
            }
        }
        #endregion //Presentation


        #region Fields
        private AdminTimesheetViewModel _adminTimesheetViewModel;
        #endregion //Fields
    }
}
