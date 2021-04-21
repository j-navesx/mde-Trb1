from http.server import BaseHTTPRequestHandler, HTTPServer
import cx_Oracle
import time
import json
import cgi
import testcode

hostName = "localhost"
serverPort = 9000



class MyServer(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        self.wfile.write(bytes(json.dumps({'hello': 'world', 'received': 'ok'}), encoding='utf8'))
        testcode.outsidePrint()
        length = 0
        try:
            length = int(self.headers['Content-Length'])
        except:
            pass
        if length:
            message = json.loads(self.rfile.read(length))
            print(message)
        else:
            print("No Body")


if __name__ == "__main__":        
    webServer = HTTPServer((hostName, serverPort), MyServer)
    #conn = cx_Oracle.connect("mde_trb1","mde","mde_trb1@//localhost:1521/xe",encoding="UTF-8")
    try:
        conn = cx_Oracle.connect("mde_trb1/mde@//localhost:1521/xe")
    except KeyboardInterrupt:
        pass
    print("Server started http://%s:%s" % (hostName, serverPort))
    cursor = conn.cursor()
    sql_query = "select * from fit_user"
    result = cursor.execute(sql_query)
    print(cursor.fetchall())
    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass
    input(">>")

    webServer.server_close()
    print("Server stopped.")