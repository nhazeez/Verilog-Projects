import socket
import threading

def client_receive(client, ip_port):
    global thread
    global all_clients
    while(True):
        try:
            client_message = client.recv(4096)

            if client_message and (not "quit" in str(client_message, encoding="utf-8").lower()):

                print("Message received from: ", ip_port, ". The message is: ", str(client_message, encoding="utf-8"))

                for current_socket in all_clients:          # sending to all clients except the sender
                    if current_socket == client:
                        continue
                    else:
                        current_socket.sendall(client_message)

            else:
                break
        except:
            print("Error Receiving Message from ", ip_port )
            break
    thread -= 1
    print("Closing Client at ", ip_port)
    all_clients.remove(client)
    client.close()



def begin():
    ip = socket.gethostbyname(socket.gethostname())         # local ip address
    port = 49111
    print("Server IP is ", ip, " and Port is ", port)
    socket_server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    socket_server.bind((ip, port))
    socket_server.listen()
    global thread
    thread = 0

    global all_clients 
    all_clients = set()
    while(True):
        try:
            client, ip_port = socket_server.accept()
            new_thread = threading.Thread(target=client_receive, args=(client, ip_port))   # create new client
            thread += 1
            all_clients.add(client)
            new_thread.start()
            print("New Client Added at ", ip_port, " !",  " Total Clients: ", thread)
        except:
            break
    print("Server Terminating!")
    socket_server.close()

if __name__=="__main__":
    begin()


        

