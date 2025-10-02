let print_Binding binding =
	print_string "\x1b[38;5;153m ";
	match binding with
	| (key, sym) -> print_string (sym ^ " -> " ^ (Tsdl.Sdl.get_key_name key));
	print_endline "\x1b[0m"

let print_Key_Mapping key_mapping =
	print_endline "\x1b[38;5;152m-----Key Map-----\x1b[0m";
	List.iter print_Binding key_mapping;
	print_endline "\x1b[38;5;152m-----End-----\x1b[0m"

let print_Error msg =
	print_string "\x1b[38;5;160m";
	print_string msg;
	print_endline "\x1b[0m"

let print_Warning msg =
	print_string "\x1b[38;5;214m";
	print_string msg;
	print_endline "\x1b[0m"

let print_Assigned msg =
	print_string "\x1b[38;5;111m";
	print_string msg;
	print_endline "\x1b[0m"

