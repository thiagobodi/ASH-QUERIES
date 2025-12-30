/* 
Author: Thiago Cursi Gil Bodi - 30-12-2025
Parameters:
sql_id -> sqlid of an identified query to check
begin_time -> initial time of the interval to be checked in dd-mm-yyyy hh24:mi:ss format, eg: 23-11-2020 05:15:15
end_time -> end time of time interval to be checked in dd-mm-yyyy hh24:mi:ss format, eg: 23-11-2020 05:50:30
For a given query within the specified time interval, query will return the first exec id, the first time it was executing, the last execution id and the last time it stated to run, grouped by instance id
*/
select INST_ID, min(sql_exec_id), min(to_char(SQL_EXEC_START,'dd-mm-yyyy hh24:mi:ss)), max(sql_exec_id), max(to_char(SQL_EXEC_START,'dd-mm-yyyy hh24:mi:ss))
from dba_hist_active_sess_history
where sql_id = '&sql_id'
and sample_time between to_date('&begin_time','dd-mm-yyyy hh24:mi:ss') and to_date('&end_time','dd-mm-yyyy hh24:mi:ss')
GROUP BY INST_ID
