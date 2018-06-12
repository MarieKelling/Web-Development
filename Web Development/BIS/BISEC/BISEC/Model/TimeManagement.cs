
using System;
using System.Collections.Generic;
using System.Linq;
using BISEC.Service;

namespace BISEC.Model
{
    partial class Activity_Log
    {
        public static Activity_Log CreateCopy(Activity_Log orig)
        {
            return new Activity_Log()
            {
                activity_code = orig.activity_code,
                start_time = orig.start_time,
                end_time = orig.end_time,
                location_id = orig.location_id,
                car_id = orig.car_id,
                comments_254 = orig.comments_254,
                log_status = orig.log_status,
                employee_id = orig.employee_id,
                activity_date = orig.activity_date,
                LunchBreakMinutes = orig.LunchBreakMinutes,
                OnsiteCoEmployees = orig.OnsiteCoEmployees
            };
        }

        public static Activity_Log CreateNew(int inEmployeeID = 0) 
        {
            return new Activity_Log()
            {
                activity_date = System.DateTime.Today,
                employee_id = inEmployeeID
            };
        }
    }

    partial class TimeManagementDataContext
    {
        public List<Dropdown_Activity>GetDropdownActivity()
        {
            return this.Dropdown_Activities.OrderBy(a => a.Description).ToList();
        }

        public List<Dropdown_Car> GetDropdownCar()
        {
            return this.Dropdown_Cars.OrderBy(c => c.CAR_DESCRIPTION).ToList();
        }

        public List<Dropdown_ClientLocation> GetDropdownClientLocation()
        {
            return this.Dropdown_ClientLocations.OrderBy(cl => cl.ClientDescript).ToList();
        }

        public Activity_Log GetActivityLogByID(int inLogID)
        {
            return this.Activity_Logs.SingleOrDefault(al => al.log_id == inLogID);
        }

        public bool IsInputTimeConflict(int inlogID, int inEmployeeID, DateTime? inStartDT, DateTime? inEndDT)
        {
            var query = this.Activity_Logs.Where(l => l.employee_id == inEmployeeID && l.activity_code != "DELI" && l.log_id != inlogID
                                                     && ((inStartDT > l.start_time && inStartDT < l.end_time)
                                                        || (inEndDT > l.start_time && inStartDT < l.end_time)
                                                        || (inStartDT < l.start_time && l.start_time < inEndDT)
                                                        || (inStartDT < l.end_time && l.end_time < inEndDT)));
            return query.ToList().Count > 0;
        }

        public bool DeleteLogByID(int iLogID, bool isAdmin=false)
        {
            try
            {
                Activity_Log a = this.GetActivityLogByID(iLogID);
                if (a == null)
                {
                    throw new System.Exception("Deleted object cannot be null");
                }
                else if (a.activity_date < System.DateTime.Today && isAdmin==false)
                {
                    throw new System.Exception("Historic record cannot be deleted");
                }
                else
                {
                    this.Activity_Logs.DeleteOnSubmit(a);
                    this.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

    }
}
