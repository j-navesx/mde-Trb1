from http.server import BaseHTTPRequestHandler, HTTPServer
import sys
import os
import cx_Oracle
import time
import json
import cgi
import secrets

hostName = "localhost"
serverPort = 9000
cursor = None
conn = None

users = {}

def app_id_generator():
    return secrets.token_hex(16)

def get_queries(sqlfile):
    parsed_queries = []
    parent_dir = __file__.strip("src\servertest.py") + '\querrys/'
    for root, dirs, files in os.walk(parent_dir):
        if sqlfile in files:
            directory = root+"/"+sqlfile
            with open(directory) as file:
                queries = file.read()
                queries = queries.split(';')
                queries_copy = list(queries)
                for querry in queries_copy:
                    q = querry.splitlines()
                    q_copy = list(q)
                    for line in q_copy:
                        if line.startswith('--') or line.startswith('\n--'):
                            q.remove(line);
                    q = ''.join(map(str,q))
                    parsed_queries.append(q)
                try:
                    parsed_queries.remove('')
                except:
                    pass  
    return parsed_queries

def execute_queries(queries, error=False):
    error_flag = False
    results = []

    if isinstance(queries, list):
        for querry in queries:
            try:
                cursor.execute(querry)
                results.append(cursor.fetchall())
            except cx_Oracle.DatabaseError as ex:
                if error:
                    print(ex)
                    print('\n',querry,'\n')
                error_flag = True
                results.append("ERROR")
            except cx_Oracle.InterfaceError:
                pass
    else:
        try:
            cursor.execute(queries)
            results = (cursor.fetchall())
        except cx_Oracle.DatabaseError as ex:
            if error:
                print(ex)
                print('\n',queries,'\n')
            error_flag = True
            results = ("ERROR")
        except cx_Oracle.InterfaceError:
            pass
    return results, error_flag

def handle_get_request(self, message:dict):
    app = message.get("appid")
    ticket = message.get("action")
    new_message = dict(message)
    new_args = new_message.get("args")
    succ = {"success":1}
    fail = {"success":0}
    send_func = lambda x: self.wfile.write(x.encode('utf-8'))

    if message.get("appid") == "request":
        print("App Id requested")
        app_id = app_id_generator()
        print("Served Id:\n",app_id)
        jsonsend = {"appid":str(app_id)}
        send_func(json.dumps(jsonsend))

    if message.get("appid") != "request" or not None:
        
        if ticket == "get_home":
            print("Getting Home Screen to "+app)
            q = "select * from home_screen where fit_user_id="+str(users[app])
            result, error_flag = execute_queries(q)
            result = list(result[0])
            result.pop(0)
            for key, value in zip(new_args, result):
                new_args[key] = value
            print("Sending:",new_message)
            send_func(json.dumps(new_message))
        
        if ticket == "get_friends_list":
            print("Getting Friends List to "+app)
            q = "select * from friends_list_screen where fit_user_id="+str(users[app])
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["users"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))

        
        if ticket == "get_friends_request":
            print("Getting Friends Request to "+app)
            q = "select * from friends_request_screen where fit_user_id1="+str(users[app])
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["users"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))
        
        if ticket == "get_notifications":
            print("Getting Notifications to "+app)
            q = "select * from notification_screen where fit_user_id="+str(users[app])+" and date_hour between sysdate - "+str(new_args["days"])+" and sysdate"
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["notifications"] = result
            new_args["days"] = len(result)
            print("Sending:",new_message)
            send_func(json.dumps(new_message))
        
        if ticket == "get_transactions":
            print("Getting Transactions to "+app)
            q = "select * from transactions_screen where fit_user_id = "+str(users[app])
            result, error_flag = execute_queries(q, True)
            print(result)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["transactions"] = result
            new_args["days"] = len(result)
            print("Sending:",new_message)
            send_func(json.dumps(new_message))

        if ticket == "get_daily_status":
            print("Getting Daily Status to "+app)
            q = "select * from daily_status_screen where fit_user_id="+str(users[app])+" and status_date between to_date('"+new_args["begin_date"]+"','YYYY-MM-DD') and to_date('"+new_args["end_date"]+"','YYYY-MM-DD')+1"
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["status"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))
        
        if ticket == "get_exercises":
            print("Getting Exercises to "+app)
            q = "select * from recent_exercises_screen where fit_user_id="+str(users[app])
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["exercises"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))
        
        if ticket == "get_nonactive_users":
            print("Getting Non Active Users to "+app)
            q = "select id, name, active, begin_date, end_date, total_paid(id, begin_date, end_date) as total_paid from nonactive_users"
            result, error_flag = execute_queries(q, True)
            print(result)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["users"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))
        
        if ticket == "get_user_activities":
            print("Getting Non Active Users to "+app)
            q = "select * from user_activities_screen"
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["users"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))

        if ticket == "get_users_paid":
            print("Getting Users Paid to "+app)
            q = "select id, name, premium, total_paid(user_paid_screen.id, to_date('"+new_args["begin_date"]+"','YYYY-MM-DD'),sysdate) as total_paid from user_paid_screen"
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["users"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))

        if ticket == "get_leaderboard":
            print("Getting User Leaderboard to"+app)
            q = "select * from my_leaderboard_screen where totals_fit_user_id ="+str(users[app])
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            [line.pop(0) for line in result]
            new_args["data"] = result
            print("Sending:",new_message)
            send_func(json.dumps(new_message))

        if ticket == "get_activities_available":
            print("Getting Activities Available to"+app)
            q = "select name from activities_template"
            result, error_flag = execute_queries(q)
            result = list(map(list,result))
            new_args["activities"] = result
            print("Sending:", new_message)
            send_func(json.dumps(new_message))

    print("\n")
    conn.commit()


def handle_post_request(self, message:dict):
    app = message.get("appid")
    ticket = message.get("action")
    args = message.get("args")
    new_message = {}
    succ = {"success":1}
    fail = {"success":0}
    send_func = lambda x: self.wfile.write(x.encode('utf-8'))

    if message.get("appid") != "request" or not None:
        
        if ticket == "login":
            print("Login requested")
            try:
                assert len(message.get("args")) > 0
            except AssertionError:
                print("Insuffiecient login Data")
            querry = "select check_password('"+message.get("args").get("username")+"','"+message.get("args").get("password")+"') from dual"
            result, error_flag = execute_queries(querry)
            result = result[0][0]
            if not error_flag and result != None:
                print("Login successful")
                users[message.get("appid")] = result
                result, error_flag = execute_queries("update fit_user set active=1 where id = " + str(users[message.get("appid")]))
                new_message["success"] = 1
                send_func(json.dumps(new_message))
            else:
                print("Incorrect login or login error")
                new_message["success"] = 0
                send_func(json.dumps(new_message))
        
        
        if ticket == "create_user":
            print("Create User Requested for "+app)
            q = "begin create_user('"+args["username"]+"','"+args["password"]+"','"+args["email"]+"','"+args["name"]+"',"+str(args["weight"])+","+str(args["height"])+",to_date('"+args["bday"]+"','YYYY-MM-DD'),'"+args["gender"]+"'); end;"
            result, error_flag = execute_queries(q)
            if error_flag:
                send_func(json.dumps(fail))
            else:
                send_func(json.dumps(succ))

        if ticket == "create_activities":
            print("Create Activity Requested for "+app)
            q = "begin create_activities_template('"+args["name"]+"',"+str(args["cal_step_mult"])+","+str(args["cal_dist_mult"])+","+str(args["cal_time_mult"])+"); end;"
            result, error_flag = execute_queries(q)
                
        if ticket == "create_exercises":
            print("Create Exercise for"+app)
            q = "select id from activities_template where name='" + args["act_name"]+"'"
            result, error_flag = execute_queries(q)
            act_id = result[0][0]
            if act_id > 0:
                q = "begin create_exercises("+str(act_id)+","+str(users[app])+"); end;"
                result, error_flag = execute_queries(q)
                if error_flag:
                    send_func(json.dumps(fail))
                else:
                    send_func(json.dumps(succ))
            else:
                send_func(json.dumps(fail))
        
        if ticket == "create_friends":
            print("Send Friend Request for"+app)
            q = "select fit_user_id from profile where name='" + args["name"]+"'"
            result, error_flag = execute_queries(q)
            u_id = result[0][0]
            if u_id > 0:
                q = "begin create_friends("+str(users[app])+","+str(u_id)+"); end;"
                result, error_flag = execute_queries(q, True)
                if error_flag:
                    send_func(json.dumps(fail))
                else:
                    send_func(json.dumps(succ))
            else:
                send_func(json.dumps(fail))
                
        if ticket == "create_transaction":
            print("Create Transaction for"+app)
            q = "begin create_transactions ("+str(users[app])+", TO_NUMBER('"+str(args["value"])+"', '9.99')); end;"
            result, error_flag = execute_queries(q, True)
            print(result)


    print("\n")
    conn.commit()          

def handle_put_request(self, message:dict):
    pass

def handle_patch_request(self, message:dict):
    app = message.get("appid")
    ticket = message.get("action")
    args = message.get("args")
    new_message = {}
    succ = {"success":1}
    fail = {"success":0}
    send_func = lambda x: self.wfile.write(x.encode('utf-8'))
    if message.get("appid") != "request" or not None:
        
        if ticket == "update_exercises":
            print("Update Exercise for"+app)
            q = "begin update_exercises("+str(users[app])+", TO_NUMBER('"+str(args["distance"])+"', '99999.99'), "+str(args["steps"])+","+str(args["bpm"])+"); end;"
            result, error_flag = execute_queries(q, True)
            print(result)

        if ticket == "update_friends":
            print("Update Friend for"+app)
            q = "select fit_user_id from profile where name ='"+args["name"]+"'"
            result, error_flag = execute_queries(q, True)
            fr_id = result[0][0]
            if fr_id > 0:
                q = "begin update_friends("+str(users[app])+","+str(fr_id)+"); end;"
                result, error_flag = execute_queries(q, True)
                if error_flag:
                    send_func(json.dumps(fail))
                else:
                    send_func(json.dumps(succ))
            else:
                send_func(json.dumps(fail))


        if ticket == "update_daily_goals":
            print("Update Daily Goals for"+app)
            if (args["daily_steps"]):
                q = "update daily_goals set daily_steps = "+str(args["daily_steps"])+" where fit_user_id="+str(users[app])
                result, error_flag = execute_queries(q, True)
                print("Updated steps")
            if (args["daily_cals"]):
                q = "update daily_goals set daily_cals = "+str(args["daily_cals"])+" where fit_user_id="+str(users[app])
                result, error_flag = execute_queries(q, True)
                print("Updated calories")

    print('\n')
    conn.commit()

def handle_delete_request(self, message:dict):
    app = message.get("appid")
    ticket = message.get("action")
    args = message.get("args")
    new_message = {}
    succ = {"success":1}
    fail = {"success":0}
    send_func = lambda x: self.wfile.write(x.encode('utf-8'))
    if message.get("appid") != "request" or not None:
        
        if ticket == "delete_friend":
            print("Update Friend for"+app)
            q = "select fit_user_id from profile where name ='"+args["name"]+"'"
            result, error_flag = execute_queries(q, True)
            fr_id = result[0][0]
            if fr_id > 0:
                q = "begin delete_friend("+str(users[app])+","+str(fr_id)+"); end;"
                result, error_flag = execute_queries(q, True)
                if error_flag:
                    send_func(json.dumps(fail))
                else:
                    send_func(json.dumps(succ))
            else:
                send_func(json.dumps(fail))

    print('\n')
    conn.commit()

class MyServer(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
    
    def do_GET(self):
        self._set_headers()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            handle_get_request(self,message)
    
    def do_POST(self):
        self._set_headers()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            handle_post_request(self,message)

    def do_PUT(self):
        self._set_headers()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            handle_put_request(self,message)

    def do_PATCH(self):
        self._set_headers()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            handle_patch_request(self,message)

    def do_DELETE(self):
        self._set_headers()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            handle_delete_request(self,message)        


if __name__ == "__main__":
    if(len(sys.argv) > 1):
        try:
            assert len(sys.argv) >= 4
        
        except AssertionError:
            print("\nInsufficient number of arguments\n")
            exit()
        
        webServer = HTTPServer((hostName, serverPort), MyServer)
        username = sys.argv[2]
        password = sys.argv[3]
        
        try:
            print("Connecting to Database...\n")
            connectstr = username+"/"+password+"@//localhost:1521/xe"
            conn = cx_Oracle.connect(connectstr)
        
        except cx_Oracle.DatabaseError:
            print("\nDATABASE ERROR: Username/Password not correct.\n")
            exit()

        cursor = conn.cursor()
        print("\nConnected successfully\n")

        if sys.argv[1] == '-s':
            print("\nStarting or Rebuilding Database\n")
            result, error = execute_queries(get_queries("drop_all.sql"))
            if not error:
                print("Tables Dropped")
            result, error = execute_queries(get_queries("fitness_schema.sql"))
            if not error:
                print("Database Build Successful")
            for filename in get_queries("compile_crud.txt"):
                procs = get_queries(filename)
                procs.append(' ')
                index = procs[0].find("asbegin")
                index2 = procs[0].find("isbegin")
                if index != -1:
                    index += 2
                    procs[0] = procs[0][:index] + " " + procs[0][index:]
                if index2 != -1:
                    index2 += 2
                    procs[0] = procs[0][:index2] + " " + procs[0][index2:]
                procs = ';'.join(procs)
                result, error = execute_queries(procs)
            
            if not error:
                print("Procedures Built Successfully")
        
        if sys.argv[1] == '-r':
            result, error = execute_queries("select * from fit_user")
            if not error:
                print("\nReconnected to the Database\n")
            else:
                print("\nDatabase Empty")
                print("Exiting...")
                exit()

        if sys.argv[1] == '-t':
            print("\nStarting or Rebuilding Database\n")
            result, error = execute_queries(get_queries("drop_all.sql"))
            if not error:
                print("Tables Dropped")
            result, error = execute_queries(get_queries("fitness_schema.sql"))
            if not error:
                print("Database Build Successful")
            for filename in get_queries("compile_crud.txt"):
                procs = get_queries(filename)
                procs.append(' ')
                index = procs[0].find("asbegin")
                index2 = procs[0].find("isbegin")
                if index != -1:
                    index += 2
                    procs[0] = procs[0][:index] + " " + procs[0][index:]
                if index2 != -1:
                    index2 += 2
                    procs[0] = procs[0][:index2] + " " + procs[0][index2:]
                procs = ';'.join(procs)
                result, error = execute_queries(procs)
        
        if sys.argv[1] == '-d':
            result, error = execute_queries(get_queries("drop_all.sql"))
            print("Database Dropped")

        print("Server started http://%s:%s\n" % (hostName, serverPort))

        try:
            webServer.serve_forever()
        except KeyboardInterrupt:
            pass

        webServer.server_close()
        print("Server stopped.")
    
    else:
        print("\nNo arguments detected\n")
        print("Use option -s to start database -r to resume database or -d to drop database\n")
        print("After the option insert username and password to the database\n")