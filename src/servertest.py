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
    parent_dir = __file__.strip("src\servertest.py") + '\queries/'
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

def execute_queries(queries):
    error_flag = False
    results = []
    for querry in queries:
        try:
            cursor.execute(querry)
            results.append(cursor.fetchall())
        except cx_Oracle.DatabaseError as ex:
            error_flag = True
            results.append("ERROR")
        except cx_Oracle.InterfaceError:
            pass
    return results, error_flag

def handle_get_request(message:dict):
    if message.get("appid") == "request":
        print("App Id requested")
        print("Served Id:\n",app_id_generator())
    if message.get("appid") != "request" or not None:
        pass
    print("\n") 


def handle_post_request(message:dict):
    if message.get("appid") != "request" or not None:
        if message.get("action") == "login":
            print("Login requested")
            try:
                assert len(message.get("args")) == 2
            except AssertionError:
                print("Insuffiecient login Data")
            if True:
                #something
                print("Login successful")
                users[message.get("appid")] = 1
                print(users)
    print("\n")           


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
            handle_get_request(message)
    
    def do_POST(self):
        self._set_headers()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            handle_post_request(message)


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
        
        if sys.argv[1] == '-r':
            result, error = execute_queries(["select * from fit_user"])
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