"""Run locally: python run.py --open-browser"""
import argparse
import errno
import socket
import threading
import webbrowser

import uvicorn


def reserve_port(preferred_port):
    """Reserve the first available local port so Uvicorn can reuse the socket."""
    for port in range(preferred_port, min(preferred_port + 10, 65536)):
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            server_socket.bind(("127.0.0.1", port))
            server_socket.listen(2048)
        except OSError as error:
            server_socket.close()
            if error.errno == errno.EADDRINUSE:
                continue
            raise
        return server_socket, port
    raise SystemExit(f"Ports {preferred_port}–{min(preferred_port + 9, 65535)} are busy.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="SANA local Kazakh text detector")
    parser.add_argument("--port", type=int, default=8765)
    parser.add_argument("--open-browser", action="store_true")
    args = parser.parse_args()
    server_socket, port = reserve_port(args.port)
    if port != args.port:
        print(f"Port {args.port} is busy; using port {port} instead.", flush=True)
    print(f"SANA is running at http://127.0.0.1:{port}", flush=True)
    if args.open_browser:
        threading.Timer(1.5, lambda: webbrowser.open(f"http://127.0.0.1:{port}")).start()
    try:
        config = uvicorn.Config("app.main:app", host="127.0.0.1", port=port, access_log=False)
        uvicorn.Server(config).run(sockets=[server_socket])
    finally:
        server_socket.close()
