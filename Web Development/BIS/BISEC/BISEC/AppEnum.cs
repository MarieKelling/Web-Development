using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BISEC
{
    public enum EquipmentListType 
    { 
        MissingPaymentOption, 
        CompletedEquipment,
        OpenRepair
    }

    public enum ReportName
    {
        OpenRepair,
        AdminTimesheetSummary,
        MissingPaymentOption
    }
    
}
