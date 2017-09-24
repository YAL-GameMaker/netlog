#define netlog_preinit
/// ()
global.netlog_socket = undefined;
global.netlog_buffer = undefined;
global.netlog_ready = false;
//#netlog_is_ready = (global.netlog_ready)

#define netlog_cleanup
/// ()
var l_skt = global.netlog_socket;
if (l_skt != undefined) {
	network_destroy(l_skt);
	global.netlog_socket = undefined;
}
var l_buf = global.netlog_buffer;
if (l_buf != undefined) {
	buffer_delete(l_buf);
	global.netlog_buffer = undefined;
}
global.netlog_ready = false;

#define netlog_init
/// (url, port): Attempts connecting to netlog server (if available).
var l_skt = network_create_socket(network_socket_tcp);
if (network_connect_raw(l_skt, argument0, argument1) >= 0) {
	global.netlog_socket = l_skt;
	global.netlog_buffer = buffer_create(16, buffer_grow, 1);
	return true;
}
network_destroy(l_skt);
return false;

#define netlog_async_net
/// (): Should be added to Async - Networking event
if (async_load[?"type"] == network_type_data
	&& async_load[?"id"] == global.netlog_socket
) {
	global.netlog_ready = buffer_read(async_load[?"buffer"], buffer_string) == "NETLOG OK";
}

#define netlog
/// (message): Sends a message either to server (if connected) or to show_debug_message.
var l_msg = argument0;
if (global.netlog_ready) {
	var l_buf = global.netlog_buffer;
	buffer_seek(l_buf, buffer_seek_start, 0);
	buffer_write(l_buf, buffer_text, l_msg);
	buffer_write(l_buf, buffer_u8, 10);
	if (network_send_raw(global.netlog_socket, l_buf, buffer_tell(l_buf)) >= 0) exit;
}
show_debug_message(l_msg);
