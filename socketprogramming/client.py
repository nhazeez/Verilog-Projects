import socket
import threading

def server_receive():
    global client_socket
    global ip
    global port
    while(True):
        try:
            server_message = client_socket.recv(4096)
            if(server_message):
                print("Message received from: ", (ip, port) , ". The message is: ", str(server_message, encoding="utf-8"))
            else:
                continue
        except:
            print("Client Disconnected or Error Receiving Message from Server")
            break

def server_send():
        global client_socket
        while(True):
            message = input("What do you want to do: Connect, Send, Quit?\n")
            try:
                if "connect" in message.lower():
                    print("Already Connected!")
                else:
                    if "send " in message.lower():
                        message = message[5:]           # remove "send " or first few characters from string
                        client_socket.send(bytes(message, encoding="utf-8"))
                    elif "send" in message.lower():
                        message = message[4:]           # remove "send" or first few characters from string
                        client_socket.send(bytes(message, encoding="utf-8"))

                    
                    try:
                        if "quit" in message.lower():
                            client_socket.send(bytes(message, encoding="utf-8"))
                            print("Server has disconnected the Client")
                            break
                    except:
                        print("Message Failed to Send!")
                        break
            except:
                continue
                    


def begin():
    global ip    
    ip = socket.gethostbyname(socket.gethostname())         # local ip address
    global port 
    port = 49111
    global client_socket
    
    while(True):
        message = input("What do you want to do: Connect, Send, Quit?")
        if "connect" in message.lower():
            client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

            try:
                client_socket.connect((ip, port))
                print("Connection Established to ", (ip, port))
            except:
                print("Unable to connect to Server")

            receive_thread = threading.Thread(target=server_receive)
            receive_thread.start()
            server_send()
            break
        else:
            print("Not Connected to Any Server!")
            continue
    
    try:
        client_socket.close()
    except:
        pass

if __name__=="__main__":
    begin()