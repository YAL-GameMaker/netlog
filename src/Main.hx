import sys.net.Host;
import sys.net.Socket;

class Main {
	static var lock = false;
	static function clientThread(cl:Socket) {
		var peer = cl.peer();
		var ident = peer.host + ":" + peer.port;
		Sys.println(ident + " connected.");
		//
		cl.output.writeString("NETLOG OK");
		cl.output.writeByte(0);
		cl.output.flush();
		//
		while (true) {
			try {
				var text = cl.input.readLine();
				while (lock) { }
				lock = true;
				Sys.println(text);
				lock = false;
			} catch (_:Dynamic) {
				break;
			}
		}
		Sys.println(ident + " disconnected.");
	}
	static function getClientThread(cl:Socket) {
		return function() clientThread(cl);
	}
	static inline var defPort = 5101;
	static function main() {
		var args = Sys.args();
		var wait = args.length == 0;
		var i = 0;
		var port = null;
		while (i < args.length) {
			switch (args[i]) {
				case "--port": {
					port = Std.parseInt(args[i + 1]);
					args.splice(i, 2);
				};
				default: i += 1;
			}
		}
		if (port == null) {
			Sys.print('Port (default $defPort): ');
			port = Std.parseInt(Sys.stdin().readLine());
			if (port == null) port = defPort;
		}
		var sv = new Socket();
		try {
			sv.bind(new Host("0.0.0.0"), port);
			sv.listen(3);
			Sys.println('Listening on port $port...');
		} catch (e:Dynamic) {
			Sys.println('Couldn\'t start a server on port $port: $e');
			if (wait) Sys.stdin().readByte();
			return;
		}
		while (true) {
			var cl = sv.accept();
			var fn = getClientThread(cl);
			#if (neko)
			neko.vm.Thread.create(fn);
			#elseif (cs)
			new cs.system.threading.Thread(fn).Start();
			#else
			throw "not implemented";
			#end
		}
	}
}
