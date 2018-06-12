using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BISEC.Service
{
    public static class DateTimeExtensions
    {
        public static DateTime StartOfWeek(this DateTime dt, DayOfWeek startOfWeek)
        {
            int diff = dt.DayOfWeek - startOfWeek;
            if (diff < 0) { diff += 7; }
            DateTime d = dt.AddDays(-1 * diff).Date;
            return dt.AddDays(-1 * diff).Date;
        }

        public static bool IsBetween(this DateTime? dt, DateTime? start, DateTime? end)
        {
            return dt >= start && dt <= end;
        }
    }
}
