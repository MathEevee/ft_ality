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
	print_string "\x1b[38;5;203m";
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

let print_Combo combo =
	let split_combo = Str.split (Str.regexp ",") combo in
	let rec print_Combo_split split_combo =
		match split_combo with
		| [] -> ()
		| head :: [] -> 
			print_endline ("\x1b[38;5;147m" ^ head ^ "\x1b[0m")
		| head :: tail ->
			print_string "\x1b[38;5;147m";
			print_string head;
			print_string " | \x1b[0m";
			print_Combo_split tail
	in print_Combo_split split_combo
