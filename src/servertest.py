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
                parsed_queries.remove('')   
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
            error_flag = True
            results = ("ERROR")
        except cx_Oracle.InterfaceError:
            pass
    return results, error_flag

def handle_get_request(self, message:dict):
    ticket = message.get("action")
    send_func = lambda x: self.wfile.write(x.encode('utf-8'))

    if message.get("appid") == "request":
        print("App Id requested")
        app_id = app_id_generator()
        print("Served Id:\n",app_id)
        jsonsend = "{\""+str(app_id)+"\"}"
        send_func(jsonsend)

    if message.get("appid") != "request" or not None:
        
        if ticket == "get_home":
            pass
        
        if ticket == "get_friends_list":
            pass
        
        if ticket == "get_friends_request":
            pass
        
        if ticket == "get_notifications":
            pass
        
        if ticket == "get_transactions":
            pass
        
        if ticket == "get_daily_status":
            pass
        
        if ticket == "get_transactions":
            pass
        
        if ticket == "get_transactions":
            pass
        
        if ticket == "get_exercises":
            pass
        
        if ticket == "get_nonactive_users":
            pass
        
        if ticket == "get_user_activitie":
            pass
    print("\n") 


def handle_post_request(self, message:dict):
    ticket = message.get("action")
    send_func = lambda x: self.wfile.write(x.encode('utf-8'))

    if message.get("appid") != "request" or not None:
        
        if ticket == "login":
            print("Login requested")
            try:
                assert len(message.get("args")) > 0
            except AssertionError:
                print("Insuffiecient login Data")
            querry = "select check_password('"+message.get("args")[0].get("username")+"','"+message.get("args")[0].get("password")+"') from dual"
            result, error_flag = execute_queries(querry)
            result = result[0][0]
            if not error_flag and result != 0:
                print("Login successful")
                users[message.get("appid")] = result
                jsonsend = "{"+str(result)+"}"
                send_func(jsonsend)
                print(users)
            else:
                print("Incorrect login or login error")
        
        
        if ticket == "create_user":
            pass
        
        if ticket == "create_activities":
            pass
        
        if ticket == "create_daily_goals":
            pass
        
        if ticket == "create_daily_status":
            pass
        
        if ticket == "create_exercises":
            pass
        
        if ticket == "create_friends":
            pass
        
        if ticket == "create_notice":
            pass
        
        if ticket == "create_transaction":
            pass
        
        if ticket == "create_user_activity":
            pass
    
    print("\n")          

def handle_put_request(self, message:dict):
    pass

def handle_patch_request(self, message:dict):
    ticket = message.get("action")
    send_func = lambda x: self.wfile.write(x.encode('utf-8'))

    if message.get("appid") != "request" or not None:
        if ticket == "update_exercises":
            pass
        if ticket == "update_friends":
            pass
        if ticket == "update_leaderboard":
            pass

def handle_delete_request(self, message:dict):
    pass

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
            for filename in get_queries("compile_procedures.sql"):
                procs = get_queries(filename)
                procs.append(' ')
                index = procs[0].find("asbegin")
                if index != -1:
                    index += 2
                    procs[0] = procs[0][:index] + " " + procs[0][index:]
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