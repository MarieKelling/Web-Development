using BISEC.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BISEC.Service
{
    public class DataService
    {
        public static void LoadDataFromBISEM(string sql, ref DataTable inDataTable)
        {
            using (OleDbConnection conn = new OleDbConnection(BISEC.Properties.Settings.Default.BISEMConnectrionString))
            using (OleDbCommand cmd = new OleDbCommand(sql, conn))
            using (OleDbDataAdapter da = new OleDbDataAdapter(cmd))
            //using (DataTable dt = new DataTable())
            {
                try
                {
                    da.Fill(inDataTable);
                }
                catch (Exception) { }
            }
        }

        public static void LoadDataFromEQMANonVALLEYVIEW(string sql, ref DataTable inDataTable)
        {
            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            //using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    da.Fill(inDataTable);
                }
                catch (Exception) { }
            }
        }

        public static void LoadDataFromTimeMANonBISSERVER(string sql, ref DataTable inDataTable)
        {
            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            //using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    da.Fill(inDataTable);
                }
                catch (Exception ex) { }
            }
        }

        public static DataSet GetMissingPaymentOptionDetail(bool bShowActiveOnly)
        {
            string storedproc = "[APP_BISEC_MISSING_PAYMENT_DETAIL]";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataSet ds = new DataSet())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("showActiveOnly", bShowActiveOnly));

                    da.Fill(ds,"RESULT"); //the table name must match with the name in the report.
                    return ds;
                }
                catch (Exception ex) { return null; }
            }
        }

        public static int GetMissingPaymentOptionCount(bool bShowActiveOnly)
        {
            string storedproc = "[APP_BISEC_MISSING_PAYMENT_COUNTER]";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("showActiveOnly", bShowActiveOnly));

                    da.Fill(dt);
                    if (dt.Rows.Count == 1)
                        return (int)dt.Rows[0][0];
                    else
                        return -1;
                }
                catch (Exception ex) { return -1; }
            }
        }

        #region Equipment
        /// <summary>
        /// Load employee equipment queue
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="inDataTable"></param>
        public static DataTable LoadEmployeeEquipment(string sEmployeeName)
        {
            string storedproc = "dbo.App_BISEC_GetEmployeeEquipmentQueue";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("emp_name", sEmployeeName));

                    da.Fill(dt);
                    return dt;
                }
                catch (Exception ex) { return null; }
            }
        }

        public static int GetEmployeeEQCount(string sEmployeeName)
        {
            string storedproc = "APP_BISEC_GetEmployeeEquipmentQueue_COUNTER";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("emp_name", sEmployeeName));

                    da.Fill(dt);
                    if (dt.Rows.Count == 1)
                        return (int)dt.Rows[0][0];
                    else
                        return -1;
                }
                catch (Exception ex) { return -1; }
            }
        }

        /// <summary>
        /// Get Open Repair Count
        /// </summary>
        /// <returns></returns>
        public static int GetOpenRepairCount()
        {
            string storedproc = "APP_BISEC_GetOpenRepair_COUNTER";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    
                    da.Fill(dt);
                    if (dt.Rows.Count == 1)
                        return (int)dt.Rows[0][0];
                    else
                        return -1;
                }
                catch (Exception ex) { return -1; }
            }
        }

        public static DataSet LoadOpenRepair()
        {
            string storedproc = "dbo.App_BISEC_GetOpenRepair";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataSet ds = new DataSet())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    
                    da.Fill(ds,"dsEQMAN");
                    return ds;
                }
                catch (Exception ex) { return null; }
            }
        }

        /// <summary>
        /// Load equipment note
        /// </summary>
        /// <param name="iEquipmentID"></param>
        /// <returns></returns>
        public static DataTable LoadEquipmentNote(int iEquipmentID)
        {
            string storedproc = "App_BISEC_GetEquipmentNote";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("equipment_id", iEquipmentID));

                    da.Fill(dt);
                    return dt;
                }
                catch (Exception) { return null; }
            }
        }

        public static bool AddEquipmentNote(int iRelatedEQId, string sNote, string sEmployeeName)
        {
            bool rslt = false;
            int bisem_emp_id = 0;
            int newID=0;

            if (string.IsNullOrEmpty(sNote))
                return rslt;

            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.EQMANConnectionString))
            using (SqlCommand cmd = new SqlCommand("fnLookupBISEMEmployeeID",conn))
            {
                cmd.CommandType=CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@fullname", sEmployeeName));
                var rtnParameter = cmd.Parameters.Add("@returnval", SqlDbType.Int);
                rtnParameter.Direction  = ParameterDirection.ReturnValue;

                if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                try 
                {
                    cmd.ExecuteNonQuery();
                    bisem_emp_id = Int32.Parse(rtnParameter.Value.ToString());
                }
                catch(Exception ex)
                {
                    PrivateHelper.ShowErrorMessage(ex.Message);
                }
            }

            if (bisem_emp_id <= 0)
                return rslt;
            else 
            {
                // add note to live prod (BISEM)
                string sql = @"INSERT INTO Equipment_Notes ([Note],RelatedEquipmentId,CreatedById) 
                            VALUES (@Notes, @EquipmentId, @EmployeeID)";
                            //VALUES ('" + inNotes + "'," + EquipmentID.ToString() + "," + inEmployeeId.ToString() + ")";

                using (OleDbConnection conn = new OleDbConnection(Properties.Settings.Default.BISEMConnectrionString))
                using (OleDbCommand cmd = new OleDbCommand(sql, conn))
                {
                    try
                    {
                        cmd.Parameters.Add(new OleDbParameter("@Notes", sNote));
                        cmd.Parameters.Add(new OleDbParameter("@EquipmentID", iRelatedEQId));
                        cmd.Parameters.Add(new OleDbParameter("@EmployeeID", bisem_emp_id));
                        cmd.Parameters.Add(new OleDbParameter("@CreationDate", DateTime.Now));
                        if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();

                        cmd.ExecuteNonQuery();
                        
                        // get last inserted id
                        cmd.CommandText="SELECT @@IDENTITY";
                        newID = (int)cmd.ExecuteScalar();

                        conn.Close();
                    }
                    catch (Exception ex)
                    {
                        PrivateHelper.ShowErrorMessage("Failed to insert note: " + ex.Message + Environment.NewLine + sql);
                        return rslt;
                    }
                }



                // add note to back-end prod (EQMAN on ValleyView Server)
                sql = @"INSERT INTO Equipment_Notes ([NoteId], [Note],[RelatedEquipmentId],[CreatedById],[Date]) 
                            VALUES (@NoteId, @Notes, @EquipmentId, @EmployeeID, @CreationDate)";

                using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.EQMANConnectionString))
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Notes", sNote));
                        cmd.Parameters.Add(new SqlParameter("@NoteId", newID=0));
                        cmd.Parameters.Add(new SqlParameter("@EquipmentID", iRelatedEQId));
                        cmd.Parameters.Add(new SqlParameter("@EmployeeID", bisem_emp_id));
                        cmd.Parameters.Add(new SqlParameter("@CreationDate", System.DateTime.Now));
                        if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        
                        conn.Close();
                        rslt = true;
                    }
                    catch (Exception ex)
                    {
                        PrivateHelper.ShowErrorMessage("Failed to insert note: " + ex.Message + Environment.NewLine + sql);
                        return rslt;
                    }
                }

                return rslt;
            }
        }
        #endregion //Equipment


        #region EMployee
        public static DataTable LoadEmployeeInfo()
        {
            string storedproc = "dbo.APP_BISEC_GET_EMPLOYEE_INFO";

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.AdminDbConnectionString))
            using (SqlCommand cmd = new SqlCommand(storedproc, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            using (DataTable dt = new DataTable())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    da.Fill(dt);
                    return dt;
                }
                catch (Exception ex) { return null; }
            }
        }
        #endregion //Employee


        #region Time Management

        public static DataTable GetEmployeeTimesheet(DateTime dtStart, DateTime dtEnd, int iEmployeeID)
        {
            DataTable dt = new DataTable();
            try
            {
                string storedproc = "dbo.App_BISEC_TimesheetDetail";
                using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
                using (SqlCommand cmd = new SqlCommand(storedproc, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@dStart", dtStart));
                    cmd.Parameters.Add(new SqlParameter("@dEnd", dtEnd));
                    cmd.Parameters.Add(new SqlParameter("@iEmployeeID", iEmployeeID));

                    da.Fill(dt);

                    return dt;
                }
            }
            catch (Exception ex)
            {
                PrivateHelper.ShowErrorMessage("Failed to load timesheet: " + Environment.NewLine + ex.Message);
                return null;
            }
        }
        public static DataTable GetEmployeePTOSummary(int iEmployeeID)
        {
            DataTable dt = new DataTable();
            try
            {
                string storedproc = "dbo.App_BISEC_EmployeePTOSummary";
                using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
                using (SqlCommand cmd = new SqlCommand(storedproc, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@iEmployeeID", iEmployeeID));

                    da.Fill(dt);

                    return dt;
                }
            }
            catch (Exception ex)
            {
                PrivateHelper.ShowErrorMessage("Failed to load PTO Summary: " + Environment.NewLine + ex.Message);
                return null;
            }
        }

        public static void Punch(int inEmployeeID, char io)
        {
            string msg;

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "dbo.spPUNCH3";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@iEmployeeID", inEmployeeID));
                cmd.Parameters.Add(new SqlParameter("@iOrO", Convert.ToChar(io)));
                //output
                SqlParameter punchdt = new SqlParameter("@punchDatetime", SqlDbType.DateTime);
                punchdt.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(punchdt);

                if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    msg = "Successfully clocked " + ((io == 'i') ? "in" : "out") + " at " + punchdt.Value.ToString();
                    PrivateHelper.ShowInfoMessage(msg);
                }
                catch (Exception e)
                {
                    msg = "Failed to clock " + ((io == 'i') ? "in" : "out") + ": ";
                    PrivateHelper.ShowErrorMessage(msg + Environment.NewLine + e.Message);
                }
            }
        }

        public static void OnsitePunchIn(int inEmployeeID)
        {
            string msg, activity_code = "OSRG";
            char io = 'i';

            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "dbo.spOnsitePunch";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@iEmployeeID", inEmployeeID));
                cmd.Parameters.Add(new SqlParameter("@iOrO", io));
                cmd.Parameters.Add(new SqlParameter("@activity_code", activity_code));
                //output
                SqlParameter punchdt = new SqlParameter("@punchDatetime", SqlDbType.DateTime);
                punchdt.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(punchdt);

                if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    //msg = "Successfully clocked " + ((io == 'i') ? "in" : "out") + " at " + punchdt.Value.ToString();
                    //PrivateHelper.ShowInfoMessage("Action completed successfully");
                }
                catch (Exception e)
                {
                    msg = "Failed to clock " + ((io == 'i') ? "in" : "out") + ": ";
                    PrivateHelper.ShowErrorMessage(msg);
                }
            }
        }

        public static bool UpdateOnsiteLog(int inEmployeeID, int inMins, int inCarId, int inLocationId, string inNotes, string inSelectedNames)
        {
            using (SqlConnection con = new SqlConnection(Properties.Settings.Default.TIMEDBConnectionString))
            using (SqlCommand cmd = new SqlCommand("dbo.App_BISEC_UpdateOnsiteLog", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@employee_id", inEmployeeID));
                cmd.Parameters.Add(new SqlParameter("@lunch_mins", inMins));
                cmd.Parameters.Add(new SqlParameter("@car_id", inCarId));
                cmd.Parameters.Add(new SqlParameter("@location_id", inLocationId));
                cmd.Parameters.Add(new SqlParameter("@selected_names", inSelectedNames));
                cmd.Parameters.Add(new SqlParameter("@notes", inNotes));

                try
                {
                    if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception ex)
                {
                    PrivateHelper.ShowErrorMessage("Failed to update onsite log: " + ex.Message);
                    return false;
                }
            }
        }

        public static bool IsClockInEnabled(int inEmployeeID)
        {

            using (SqlConnection con = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("fnClockInIsEnabled2", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@iEmployeeID", inEmployeeID));
                    var rtnPara = cmd.Parameters.Add("@rtnVal", SqlDbType.Bit);
                    rtnPara.Direction = ParameterDirection.ReturnValue;
                    if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                        return bool.Parse(rtnPara.Value.ToString());
                    }
                    catch (Exception ex)
                    {
                        return false;
                    }
                }
            }
        }

        public static bool IsEmployeeOnsite(int inEmployeeID)
        {

            using (SqlConnection con = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
            {
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandText = "dbo.fnIsOnsite2";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@iEmployeeID", inEmployeeID));
                var returnParameter = cmd.Parameters.Add("@rslt", SqlDbType.Bit);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    return bool.Parse(returnParameter.Value.ToString());
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }

        public static bool AddActivityLog(string userName, string startDate, string startTime,
               string endDate, string endTime, string activity_code, int? client_id, int? car_id, string strComments,
               int LunchMins)
        {
            string sql = "dbo.App_BISEC_AddEmployeeActivityLog";
            using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@vLogin", userName));
                //cmd.Parameters.Add(new SqlParameter("@dStart", startDate));
                //cmd.Parameters.Add(new SqlParameter("@dEnd", endDate));
                cmd.Parameters.Add(new SqlParameter("@vActivityCode", activity_code));

                SqlParameter parStartDate = new SqlParameter("@dStart", SqlDbType.Date);
                if (string.IsNullOrEmpty(startDate)) { parStartDate.Value = DBNull.Value; } else { parStartDate.Value = startDate; }
                cmd.Parameters.Add(parStartDate);

                SqlParameter parEndDate = new SqlParameter("@dEnd", SqlDbType.Date);
                if (string.IsNullOrEmpty(endDate)) { parEndDate.Value = DBNull.Value; } else { parEndDate.Value = endDate; }
                cmd.Parameters.Add(parEndDate);

                SqlParameter parClientId = new SqlParameter("@iClientId", SqlDbType.Int);
                if (client_id == null) { parClientId.Value = DBNull.Value; } else { parClientId.Value = client_id; }
                cmd.Parameters.Add(parClientId);

                SqlParameter parCarId = new SqlParameter("@iCarId", SqlDbType.Int);
                if (car_id == null) { parCarId.Value = DBNull.Value; } else { parCarId.Value = car_id; }
                cmd.Parameters.Add(parCarId);

                SqlParameter parStartTime = new SqlParameter("@tStart", SqlDbType.VarChar);
                if (startTime == null) { parStartTime.Value = DBNull.Value; } else { parStartTime.Value = startTime; }
                cmd.Parameters.Add(parStartTime);

                SqlParameter parEndTime = new SqlParameter("@tEnd", SqlDbType.VarChar);
                if (endTime == null) { parEndTime.Value = DBNull.Value; } else { parEndTime.Value = endTime; }
                cmd.Parameters.Add(parEndTime);

                cmd.Parameters.Add(new SqlParameter("@vComments", strComments));
                cmd.Parameters.Add(new SqlParameter("@iLunch", LunchMins));

                if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    PrivateHelper.ShowInfoMessage("Action completed successfully.");
                    return true;
                }
                catch (Exception e)
                {
                    PrivateHelper.ShowInfoMessage("Failed to add record: " + e.Message);
                    return false;
                }

            }
        }

        public static bool UpdateActivityLog(int logId, string startTime,
                string endTime, string activityCode, int? clientId, int? carId, string strComments, int inLunchMins,
                string inSelectedNames)
        {
            bool rslt;
            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.TIMEDBConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "dbo.spUpdateEmployeeActivityLog";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@iLogID", logId));
                cmd.Parameters.Add(new SqlParameter("@vActivityCode", activityCode));

                SqlParameter parClientId = new SqlParameter("@iClientId", SqlDbType.Int);
                if (clientId == null) { parClientId.Value = DBNull.Value; } else { parClientId.Value = clientId; }
                cmd.Parameters.Add(parClientId);

                SqlParameter parCarId = new SqlParameter("@iCarId", SqlDbType.Int);
                if (carId == null) { parCarId.Value = DBNull.Value; } else { parCarId.Value = carId; }
                cmd.Parameters.Add(parCarId);

                SqlParameter parStartTime = new SqlParameter("@tStart", SqlDbType.VarChar);
                if (startTime == null) { parStartTime.Value = DBNull.Value; } else { parStartTime.Value = startTime; }
                cmd.Parameters.Add(parStartTime);

                SqlParameter parEndTime = new SqlParameter("@tEnd", SqlDbType.VarChar);
                if (endTime == null) { parEndTime.Value = DBNull.Value; } else { parEndTime.Value = endTime; }
                cmd.Parameters.Add(parEndTime);

                cmd.Parameters.Add(new SqlParameter("@vComments", strComments));
                cmd.Parameters.Add(new SqlParameter("@iLunch", inLunchMins));

                cmd.Parameters.Add(new SqlParameter("@vSelectedNames", inSelectedNames));

                if (cmd.Connection.State == ConnectionState.Closed) cmd.Connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    rslt = true;
                }
                catch (Exception ex)
                {
                    PrivateHelper.ShowErrorMessage("SQL Error - Failed to update data: " + ex.Message);
                    rslt = false;
                }
                return rslt;
            }
        }

        public static DataTable GetListOfSelectedEmployees(string inSelectedNames)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.TIMEDBConnectionString))
            using (SqlCommand cmd = new SqlCommand("App_BISEC_ConvertStringToList", conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@selected_names", inSelectedNames));

                da.Fill(dt);
                return dt;

            }
        }

        

        public static DataTable CustomerLocations()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.TIMEDBConnectionString))
            {
                conn.Open();

                using (var cmd = new SqlCommand("SELECT * FROM dbo.vwClientLocations ORDER BY ClientDescript", conn))
                {
                    dt.Load(cmd.ExecuteReader());
                }
                conn.Close();
            }
            return dt;
        }

        public static DataTable ListOfCar(int inUserID)
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.TIMEDBConnectionString))
            {
                SqlCommand cmd = new SqlCommand("dbo.App_BISEC_GetCars", conn);
                cmd.Parameters.AddWithValue("@iEmployeeID", inUserID);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                da.Fill(dt);
                da.Dispose();
            }
            return dt;
        }

        public static DataTable ListOfEmployees(bool showAll)
        {
            DataTable dt = new DataTable();
            try
            {
                string storedproc = "dbo.App_BISEC_EmployeeDropdown";
                using (SqlConnection conn = new SqlConnection(BISEC.Properties.Settings.Default.TIMEDBConnectionString))
                using (SqlCommand cmd = new SqlCommand(storedproc, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@bShowAll", showAll));

                    da.Fill(dt);

                    return dt;
                }
            }
            catch (Exception ex)
            {
                PrivateHelper.ShowErrorMessage("Failed to load PTO Summary: " + Environment.NewLine + ex.Message);
                return null;
            }
        }

        public static DataTable GetAdminTimesheetSummary(DateTime dtStart, DateTime dtEnd)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.TIMEDBConnectionString))
            using (SqlCommand cmd = new SqlCommand("App_BISEC_GetAdminTimesheet", conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@dtStart", dtStart));
                cmd.Parameters.Add(new SqlParameter("@dtEnd", dtEnd));

                da.Fill(dt);
                return dt;
            }
        }

        
        #endregion // Time Management


        #region Report data
        public static DataSet ReportData_AdminTimesheetSummary(DateTime dtStart, DateTime dtEnd)
        {
            DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.TIMEDBConnectionString))
            using (SqlCommand cmd = new SqlCommand("App_BISEC_ReportData_AdminTimesheet", conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@dStart", dtStart));
                cmd.Parameters.Add(new SqlParameter("@dEnd", dtEnd));

                da.Fill(ds, "RESULTS");
                return ds;
            }
        }
        #endregion Report data
    }
}

